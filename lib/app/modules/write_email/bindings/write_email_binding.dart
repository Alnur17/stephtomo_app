import 'package:get/get.dart';

import '../controllers/write_email_controller.dart';

class WriteEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WriteEmailController>(
      () => WriteEmailController(),
    );
  }
}
