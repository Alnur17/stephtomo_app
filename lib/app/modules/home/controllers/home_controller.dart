import 'dart:convert';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/college_model.dart';

class HomeController extends GetxController {
  final BookmarksController bookmarksController = Get.put(BookmarksController());

  var allColleges = <Datum>[].obs; // Holds original API data
  var filteredData = <Datum>[].obs; // Holds search results / displayed data
  var savedColleges = <Datum>[].obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollegeData();
    bookmarksController.getBookmarkedColleges();
  }

  /// **Fetch College Data from API**
  Future<void> fetchCollegeData() async {
    try {
      isLoading(true);
      var response = await BaseClient.getRequest(api: Api.collegeData);
      var responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        CollegeModel collegeModel = CollegeModel.fromJson(responseData);
        allColleges.assignAll(collegeModel.data?.data ?? []); // Keep original data
        filteredData.assignAll(allColleges); // Initially show all data
      }
    } catch (e) {
      print("Error fetching college data: $e");
    } finally {
      isLoading(false);
    }
  }

  /// **Add Bookmark**
  Future<void> addBookmark(String collegeId) async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var body = {"college": collegeId};
      var headers = {
        "Authorization": "Bearer, $token",
        'Content-Type': 'application/json',
      };

      var response = await BaseClient.postRequest(
        api: Api.addBookMark,
        body: jsonEncode(body),
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      print("Bookmark Response: $responseData");

      if (responseData != null && responseData["success"] == true) {
        print("Bookmark added successfully");
        await bookmarksController.getBookmarkedColleges();
      }
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  /// **Toggle Bookmark**
  void toggleSaveCollege(Datum college) {
    if (isSaved(college)) {
      savedColleges.removeWhere((saved) => saved.id == college.id);
      addBookmark(college.id ?? '');
    } else {
      savedColleges.add(college);
      addBookmark(college.id ?? '');
    }
    update();
  }

  /// **Check if a College is Saved**
  bool isSaved(Datum college) {
    return savedColleges.any((saved) => saved.id == college.id);
  }

  /// **Search Colleges (Fixed Logic)**
  void searchColleges(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredData.assignAll(allColleges); // Reset data to full dataset
    } else {
      var results = allColleges.where((college) =>
      (college.collegeName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (college.coachName?.toLowerCase().contains(query.toLowerCase()) ?? false)
      ).toList();

      filteredData.assignAll(results);
    }

    filteredData.refresh();
  }

  /// **Reset Data on Back Navigation**
  void resetData() {
    searchQuery.value = "";
    filteredData.assignAll(allColleges);
    filteredData.refresh();
  }
}
