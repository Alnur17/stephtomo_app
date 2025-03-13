import 'package:get/get.dart';

import '../../../../common/helper/local_store.dart';

class MyPlanController extends GetxController {
  var currentPlan = 'No Plan'.obs;
  var currentPrice = '0.00'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPlan(); // Call without await since we’ll handle async internally
  }

  void loadPlan() {
    // getData is synchronous with GetStorage
    currentPlan.value = LocalStorage.getData(key: 'current_plan') ?? 'No Plan';
    currentPrice.value = LocalStorage.getData(key: 'current_price') ?? '0.00';
  }

  Future<void> updatePlan(String plan, String price) async {
    currentPlan.value = plan;
    currentPrice.value = price;
    // saveData is asynchronous
    await LocalStorage.saveData(key: 'current_plan', data: plan);
    await LocalStorage.saveData(key: 'current_price', data: price);
  }
}
