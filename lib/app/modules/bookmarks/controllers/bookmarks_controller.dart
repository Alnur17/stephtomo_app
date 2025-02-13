import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/api.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/base_client.dart';
import '../models/college_bookmarks_model.dart';

class BookmarksController extends GetxController {
  var isLoading = false.obs;
  var savedColleges = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBookmarkedColleges();
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
        CollegeBookMarksModel model = CollegeBookMarksModel.fromJson(responseData);
        if (model.success ?? false) {
          savedColleges.assignAll(model.data?.data ?? []);
        }
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    } finally {
      isLoading(false);
    }
  }

  /// **Remove Bookmark**
  Future<void> removeBookmark(String collegeId) async {
    try {
      var response = await BaseClient.deleteRequest(
        api: Api.removeBookMark(collegeId),
      );

      var responseData = await BaseClient.handleResponse(response);
      print("Remove Bookmark Response: $responseData");

      if (responseData != null && responseData["success"] == true) {
        print("Bookmark removed successfully");
        savedColleges.removeWhere((college) => college.id == collegeId);
        savedColleges.refresh();
      }
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

  /// **Toggle Bookmark (Remove from Saved List)**
  void toggleSaveCollege(Datum college) {
    if (isSaved(college)) {
      savedColleges.removeWhere((saved) => saved.id == college.id);
    } else {
      savedColleges.add(college);

    }
    update();
  }

  /// **Check if a College is Saved**
  bool isSaved(Datum college) {
    return savedColleges.any((saved) => saved.id == college.id);
  }
}
