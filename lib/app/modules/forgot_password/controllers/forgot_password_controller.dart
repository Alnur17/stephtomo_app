import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/email_verification/views/email_verification_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  ///forgot Password Controller
  Future forgotPassword({
    required String email,
  }) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['email'] = email;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.forgotPassword,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);
        Get.to(() => EmailVerificationView(email: email,),transition: Transition.fade);

        isLoading(false);
      } else {
        throw 'forgot in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
