import 'package:get/get.dart';

import 'package:stephtomo_app/app/modules/profile/controllers/all_email_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllEmailController>(
      () => AllEmailController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
