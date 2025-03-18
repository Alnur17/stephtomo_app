import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stephtomo_app/app/modules/profile/views/payment_view.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/subscription_packages_model.dart';
import 'my_plan_controller.dart';

class SubscriptionPlanController extends GetxController {
  var selectedPlan = "".obs;
  var selectedPrice = 0.0.obs;
  var isLoading = false.obs;
  var subscriptionPackages = <Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPackages();
  }

  void setPlan(String plan, double price) {
    selectedPlan.value = plan;
    selectedPrice.value = price;
  }


  Future<void> fetchSubscriptionPackages() async {
    isLoading.value = true;

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: Api.packages,
          headers: headers,
        ),
      );

      if (responseBody != null) {
        SubscriptionPackagesModel packagesModel =
        SubscriptionPackagesModel.fromJson(responseBody);
        subscriptionPackages.assignAll(packagesModel.data);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch subscription packages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPaymentSession() async {
    isLoading.value = true;

    String token = LocalStorage.getData(key: AppConstant.token) ?? "";
    String email = "";
    if (token.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      email = decodedToken["email"] ?? "";
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.subscription(selectedPlan.value.toLowerCase(), email),
        headers: headers,
      ),
    );

    isLoading.value = false;

    if (responseBody != null) {
      // // Store the subscription details after successful payment
      // await Get.put(MyPlanController()).updatePlan(
      //   selectedPlan.value,
      //   selectedPrice.value.toString(),
      // );

      Get.to(
            () => PaymentView(paymentUrl: responseBody["data"]["url"]),
      );
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }
}