import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stephtomo_app/app/modules/bookmarks/controllers/bookmarks_controller.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/school_model.dart';

class HomeController extends GetxController {
  final BookmarksController bookmarksController = Get.put(BookmarksController());
  final GetStorage storage = GetStorage(); // Local storage for bookmark persistence

  var allSchool = <Datum>[].obs; // Holds all API data
  var filteredData = <Datum>[].obs; // Holds search results / displayed data
  var savedSchool = <String>[].obs; // Stores only school IDs for bookmarking
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
      savedSchool.assignAll(savedIds.map((id) => id.toString()).toList());
    }
  }

  /// **Fetch College Data from API**
  Future<void> fetchCollegeData() async {
    try {
      isLoading(true);
      var response = await BaseClient.getRequest(api: Api.schoolData);
      var responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        SchoolModel schoolModel = SchoolModel.fromJson(responseData);
        allSchool.assignAll(schoolModel.data?.data ?? []);
        filteredData.assignAll(allSchool);
      }
    } catch (e) {
      print("Error fetching school data: $e");
    } finally {
      isLoading(false);
    }
  }

  /// **Toggle Bookmark (Local + API)**
  Future<void> toggleSaveSchool(Datum school) async {
    String schoolId = school.id ?? '';

    if (schoolId.isEmpty) return;

    if (isSaved(school)) {
      savedSchool.remove(schoolId); // Remove locally
    } else {
      savedSchool.add(schoolId); // Add locally
    }

    // Save bookmarks to GetStorage
    storage.write('saved_colleges', savedSchool.toList());
    savedSchool.refresh();

    // Call API (Add/Remove Bookmark)
    await addBookmark(schoolId);
  }

  /// **Check if a School is Saved**
  bool isSaved(Datum school) {
    return savedSchool.contains(school.id);
  }

  /// **API: Add or Remove Bookmark (Same API)**
  Future<void> addBookmark(String schoolId) async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var body = {"school": schoolId};
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

  /// **Search Schools**
  void searchSchool(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredData.assignAll(allSchool); // Reset to full dataset
    } else {
      var results = allSchool.where((school) =>
      (school.name?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
          (school.coach?.name?.toLowerCase().contains(query.toLowerCase()) ?? false)).toList();

      filteredData.assignAll(results);
    }
    filteredData.refresh();
  }

  /// **Reset Data on Back Navigation**
  void resetData() {
    searchQuery.value = "";
    filteredData.assignAll(allSchool);
    filteredData.refresh();
  }
}
