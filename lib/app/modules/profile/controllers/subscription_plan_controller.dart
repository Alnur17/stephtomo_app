
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stephtomo_app/app/modules/profile/views/payment_details_view.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class SubscriptionPlanController extends GetxController {
  var selectedPlan = "Yearly".obs;
  var selectedPrice = 100.0.obs;
  var isLoading = false.obs;

  void setPlan(String plan, double price) {
    selectedPlan.value = plan;
    selectedPrice.value = price;
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
          api: Api.subscription(selectedPlan.value.toLowerCase(), email), headers: headers),
    );

    isLoading.value = false;

    if (responseBody != null) {
      Get.to(
        () => PaymentView(paymentUrl: responseBody["data"]["url"],),
      );
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }
}
