import 'package:get/get.dart';

class HomeController extends GetxController {
  var savedColleges = <Map<String, dynamic>>[].obs;

  void toggleSaveCollege(Map<String, dynamic> college) {
    if (savedColleges.contains(college)) {
      savedColleges.remove(college);
     // Get.to(()=> SavedCollageView());
    } else {
      savedColleges.add(college);
    }
  }

  bool isSaved(Map<String, dynamic> college) {
    return savedColleges.contains(college);
  }
}
