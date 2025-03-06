import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/base_client.dart';
import 'package:stephtomo_app/app/modules/profile/views/payment_success_view.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/widgets/custom_snackbar.dart';

class PaymentController extends GetxController{

var isLoading = false.obs;

paymentResults({required String paymentLink}) async {
    try {
      isLoading.value = true;


      debugPrint("Fetching Profile Data...");


      var headers = {
        'Content-Type': "application/json",
      };

      var response = await BaseClient.getRequest(api: paymentLink, headers: headers);

      if (response.statusCode == 200) {
        Get.to(() => PaymentSuccessView());
      }else if(response.statusCode == 400){
        Get.to(() => PaymentSuccessView());
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      kSnackBar(
        message: "Error fetching profile: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
}