import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/dashboard/views/dashboard_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/subscription_plan_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;

  Future loginController({
    required String email,
    required String password,
    required bool isRemember,
  }) async {
    try {
      isLoading(true);
      String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);
      var map = {
        "email": email.toLowerCase(),
        "password": password,
        'fcm_token': fcmToken,
        "is_remember_me": isRemember,
      };

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      print(map);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.login, body: jsonEncode(map), headers: headers),
      );
      if (responseBody != null) {
        String message = responseBody['message'].toString();

        bool success = responseBody['success'];
        String token = responseBody['data']['token'].toString();
        bool hasSubscription = responseBody['data']['has_access'];

        LocalStorage.saveData(key: AppConstant.token, data: token);

        kSnackBar(message: message, bgColor: AppColors.green);

        if (success == true && hasSubscription == true) {
          Get.offAll(() => DashboardView());
        } else {
          Get.offAll(() => SubscriptionPlanView());
        }

        isLoading(false);
      } else {
        throw 'SignIn in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
