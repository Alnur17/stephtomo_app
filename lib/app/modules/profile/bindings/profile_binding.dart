import 'package:get/get.dart';

import 'package:stephtomo_app/app/modules/profile/controllers/all_email_controller.dart';
import 'package:stephtomo_app/app/modules/profile/controllers/settings_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<AllEmailController>(
      () => AllEmailController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
