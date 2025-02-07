import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/sign_in/views/sign_in_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';

class SettingsController extends GetxController {
  var isLoading = false.obs;


  ///change password
  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      var map = {
        "oldPassword": currentPassword,
        "newPassword": newPassword
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer, ${LocalStorage.getData(key: AppConstant.token)}",
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: Api.changePassword,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        Get.offAll(()=> SignInView());

        isLoading(false);
      } else {
        throw 'reset pass in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

}
