import 'dart:convert';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/college_model.dart';

class HomeController extends GetxController {
  var savedColleges = <Datum>[].obs;
  var searchQuery = ''.obs;
  var filteredData = <Datum>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollegeData();
    getBookmarkedColleges();
  }

  /// **Fetch College Data from API**
  Future<void> fetchCollegeData() async {
    try {
      isLoading(true);
      var response = await BaseClient.getRequest(api: Api.collegeData);
      var responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        CollegeModel collegeModel = CollegeModel.fromJson(responseData);
        filteredData.assignAll(collegeModel.data?.data ?? []);
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
        "Authorization": "Bearer, $token",  // Fix comma in Bearer token
        'Content-Type': 'application/json',
      };

      var response = await BaseClient.postRequest(
        api: Api.addBookMark,
        body: jsonEncode(body),
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      print("Bookmark Response: $responseData"); // Debugging

      if (responseData != null && responseData["success"] == true) {
        print("Bookmark added successfully");
        await getBookmarkedColleges(); // Refresh bookmarks
      }
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  /// **Remove Bookmark**
  // Future<void> removeBookmark(String collegeId) async {
  //   try {
  //     String token = LocalStorage.getData(key: AppConstant.token);
  //     var headers = {
  //       "Authorization": "Bearer, $token",
  //     };
  //
  //     var response = await BaseClient.deleteRequest(
  //       api: "${Api.removeBookMark}/$collegeId",
  //       headers: headers,
  //     );
  //
  //     var responseData = await BaseClient.handleResponse(response);
  //     print("Remove Bookmark Response: $responseData"); // Debugging
  //
  //     if (responseData != null && responseData["success"] == true) {
  //       print("Bookmark removed successfully");
  //       savedColleges.removeWhere((college) => college.id == collegeId);
  //     }
  //   } catch (e) {
  //     print("Error removing bookmark: $e");
  //   }
  // }

  /// **Get Bookmarked Colleges**
  Future<void> getBookmarkedColleges() async {
    try {
      isLoading(true); // Start loading state
      update();

      String token = LocalStorage.getData(key: AppConstant.token);
      print("Fetching bookmarks with token: $token");

      var response = await BaseClient.getRequest(
        api: Api.bookMarked,
        headers: {
          "Authorization": "Bearer, $token",
        },
      );

      var responseData = await BaseClient.handleResponse(response);
      print("Bookmark API Response: $responseData");

      if (responseData != null && responseData["data"] is List) {
        List<Datum> bookmarks = (responseData["data"] as List)
            .map((e) => Datum.fromJson(e))
            .toList();
        savedColleges.assignAll(bookmarks);
        print("Bookmarked colleges count: ${savedColleges.length}");
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    } finally {
      isLoading(false); // Stop loading
      update();
    }
  }


  /// **Toggle Bookmark**
  void toggleSaveCollege(Datum college) {
    if (isSaved(college)) {
      //removeBookmark(college.id ?? '');
    } else {
      addBookmark(college.id ?? '');
    }
  }

  /// **Check if a College is Saved**
  bool isSaved(Datum college) {
    return savedColleges.any((saved) => saved.id == college.id);
  }

  /// **Search Colleges**
  void searchColleges(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      fetchCollegeData();
    } else {
      filteredData.assignAll(
        filteredData.where((college) {
          return (college.collegeName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (college.coachName?.toLowerCase().contains(query.toLowerCase()) ?? false);
        }).toList(),
      );
    }
  }
}
