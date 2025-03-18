import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/api.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/base_client.dart';
import '../model/current_plan_model.dart';

class MyPlanController extends GetxController {
  var packageName = 'Free Trial'.obs;
  var endDate = ''.obs;
  var price = 0.0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPlanDetails();
    super.onInit();
  }

  Future<void> fetchPlanDetails() async {
    try {
      isLoading(true);

      // Retrieve token from LocalStorage
      String token = LocalStorage.getData(key: AppConstant.token) ?? '';


      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer, $token',
      };

      // Make GET request using BaseClient
      final response = await BaseClient.getRequest(
        api: Api.currentPlan,
        headers: headers,
      );

      final jsonData = await BaseClient.handleResponse(response);

      final currentPlan = CurrentPlanModel.fromJson(jsonData);

      if (currentPlan.success == true && currentPlan.data != null) {
        final planData = currentPlan.data!;
        packageName.value = (planData.packageName ?? 'Free Trial').toUpperCase();
        endDate.value = planData.endDate?.toIso8601String().split('T')[0] ?? '';
        price.value = planData.price ?? 0.0;
      } else {
        throw currentPlan.message ?? 'Failed to load plan details';
      }

    } catch (e) {
      kSnackBar(message: 'Failed to load plan details: $e', bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }
}