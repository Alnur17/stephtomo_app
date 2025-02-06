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

      // Handling the data with the new model structure
      if (responseData != null) {
        CollegeBookMarksModel model = CollegeBookMarksModel.fromJson(responseData);
        if (model.success ?? false) {
          savedColleges.assignAll(model.data?.data ?? []);  // Use the 'data' field to get a list of 'Datum'
        }
      }
    } catch (e) {
      print("Error fetching bookmarks: $e");
    } finally {
      isLoading(false);
    }
  }

  bool isSaved(Datum college) {
    return savedColleges.contains(college);
  }

  Future<void> toggleSaveCollege(Datum college) async {
    // Implement the toggle logic (add or remove the college from savedColleges)
  }
}
