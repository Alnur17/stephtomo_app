import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/sign_in/views/sign_in_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class CreateNewPasswordController extends GetxController {
  var isLoading = false.obs;

  Future forgotNewPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      //map['resetPasswordToken'] = "${LocalStorage.getData(key: AppConstant.resetPasswordToken)}";
      map['email'] = email;
      map['password'] = newPassword;

      var headers = {
        'Content-Type': 'application/json',
      };
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.resetForgottenPassword,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {

        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

        Get.offAll(() => SignInView());


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
