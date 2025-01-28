import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/create_new_password/views/create_new_password_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class EmailVerificationController extends GetxController {
  var isLoading = false.obs;

  Future verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;
      map['otp'] = otp;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.otpVerify,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {

        String message = responseBody['message'].toString();
         kSnackBar(message: message, bgColor: AppColors.green);

        Get.to(() => CreateNewPasswordView(email: email));

        isLoading(false);
      } else {
        throw 'verify otp in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

}
