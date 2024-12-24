import 'package:get/get.dart';

class WriteEmailController extends GetxController {
  var checkbox = List.generate(10, (index) => false.obs).obs;

  void markAll() {
    bool allSelected = checkbox.every((item) => item.value);

    for (var check in checkbox) {
      check.value = !allSelected;
    }
  }

  void toggleCheckbox(int index) {
    checkbox[index].value = !checkbox[index].value;
  }
}
