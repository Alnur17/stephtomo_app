import 'package:get/get.dart';

import 'package:stephtomo_app/app/modules/video/controllers/edit_video_controller.dart';
import 'package:stephtomo_app/app/modules/video/controllers/upload_video_controller.dart';

import '../controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVideoController>(
      () => EditVideoController(),
    );
    Get.lazyPut<UploadVideoController>(
      () => UploadVideoController(),
    );
    Get.lazyPut<VideoController>(
      () => VideoController(),
    );
  }
}
