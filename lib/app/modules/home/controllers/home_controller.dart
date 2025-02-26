import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stephtomo_app/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/college_model.dart';

class HomeController extends GetxController {
  final BookmarksController bookmarksController = Get.put(BookmarksController());
  final GetStorage storage = GetStorage(); // Local storage for bookmark persistence

  var allColleges = <Datum>[].obs; // Holds all API data
  var filteredData = <Datum>[].obs; // Holds search results / displayed data
  var savedColleges = <String>[].obs; // Stores only college IDs for bookmarking
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollegeData();
    loadLocalBookmarks(); // Load bookmarks from local storage
    bookmarksController.getBookmarkedColleges(); // Fetch API bookmarks
  }

  /// **Load Saved Bookmarks from Local Storage**
  void loadLocalBookmarks() {
    List<dynamic>? savedIds = storage.read<List<dynamic>>('saved_colleges');
    if (savedIds != null) {
      savedColleges.assignAll(savedIds.map((id) => id.toString()).toList());
    }
  }

  /// **Fetch College Data from API**
  Future<void> fetchCollegeData() async {
    try {
      isLoading(true);
      var response = await BaseClient.getRequest(api: Api.collegeData);
      var responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        CollegeModel collegeModel = CollegeModel.fromJson(responseData);
        allColleges.assignAll(collegeModel.data?.data ?? []);
        filteredData.assignAll(allColleges);
      }
    } catch (e) {
      print("Error fetching college data: $e");
    } finally {
      isLoading(false);
    }
  }

  /// **Toggle Bookmark (Local + API)**
  Future<void> toggleSaveCollege(Datum college) async {
    String collegeId = college.id ?? '';

    if (collegeId.isEmpty) return;

    if (isSaved(college)) {
      savedColleges.remove(collegeId); // Remove locally
    } else {
      savedColleges.add(collegeId); // Add locally
    }

    // Save bookmarks to GetStorage
    storage.write('saved_colleges', savedColleges.toList());
    savedColleges.refresh();

    // Call API (Add/Remove Bookmark)
    await addBookmark(collegeId);
  }

  /// **Check if a College is Saved**
  bool isSaved(Datum college) {
    return savedColleges.contains(college.id);
  }

  /// **API: Add or Remove Bookmark (Same API)**
  Future<void> addBookmark(String collegeId) async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var body = {"college": collegeId};
      var headers = {
        "Authorization": "Bearer, $token",
        'Content-Type': 'application/json',
      };

      var response = await BaseClient.postRequest(
        api: Api.addBookMark, // Same API for adding/removing
        body: jsonEncode(body),
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      if (responseData != null && responseData["success"] == true) {
        print("Bookmark updated successfully");
      }
    } catch (e) {
      print("Error updating bookmark: $e");
    }
  }

  /// **Search Colleges**
  void searchColleges(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredData.assignAll(allColleges); // Reset to full dataset
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
