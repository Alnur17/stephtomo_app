import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../bookmarks/models/school_bookmarks_model.dart';
import '../model/school_model.dart';

class HomeController extends GetxController {
  final GetStorage storage = GetStorage();

  var allSchool = <dynamic>[].obs;
  var filteredData = <dynamic>[].obs;
  var savedSchool = <String>[].obs; // Stores only school IDs for bookmarking
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchoolData();
    loadLocalBookmarks(); // Load bookmarks from local storage
  }

  /// **Load Saved Bookmarks from Local Storage**
  void loadLocalBookmarks() {
    List<dynamic>? savedIds = storage.read<List<dynamic>>('saved_colleges');
    if (savedIds != null) {
      savedSchool.assignAll(savedIds.map((id) => id.toString()).toList());
    }
  }

  /// **Fetch College Data from API**
  Future<void> fetchSchoolData() async {
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
  Future<void> toggleSaveSchool(dynamic school) async {
    String schoolId = school.id ?? '';

    if (schoolId.isEmpty) return;

    if (isSaved(school)) {
      savedSchool.remove(schoolId); // locally
    } else {
      savedSchool.add(schoolId); // locally
    }

    // Save bookmarks to GetStorage
    storage.write('saved_colleges', savedSchool.toList());
    savedSchool.refresh();

    // Calling API (Add/Remove Bookmark)
    await addBookmark(schoolId);
  }

  /// **Check if a School is Saved**
  bool isSaved(dynamic school) {
    return savedSchool.contains(school.id);
  }

  /// API: Add or Remove Bookmark (Same API)
  Future<void> addBookmark(String schoolId) async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var body = {"schoolId": schoolId};
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
      if (responseData != null && responseData["success"] == true) {
        print("Bookmark updated successfully");
      }
    } catch (e) {
      print("Error updating bookmark: $e");
    }
  }

  Future<void> getBookmarkedColleges() async {
    isLoading(true);
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var response = await BaseClient.getRequest(
        api: Api.bookMarked,
        headers: {'Authorization': "Bearer, $token"},
      );

      final responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        SchoolBookMarksModel model = SchoolBookMarksModel.fromJson(responseData);
        if (model.success ?? false) {
          savedSchool.assignAll(model.data?.data.map((e) => e.school.toString()) ?? []);
        }
      }
    } catch (e) {
      log("Error fetching bookmarks: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Search Schools
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
