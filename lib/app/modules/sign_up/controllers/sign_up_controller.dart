import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/app/modules/sign_in/views/sign_in_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/base_client.dart';
import '../views/verify_your_email_view.dart';

class SignUpController extends GetxController {

  var isLoading = false.obs;
  var firstScreenData = {}.obs;

  Rx<int> countdown = 10.obs;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  // Countdown timer logic
  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // Save first-screen data
  void saveFirstScreenData(Map<String, dynamic> data) {
    // Remove null or empty fields
    data.removeWhere((key, value) => value == null || value == '');
    firstScreenData.assignAll(data);
    LocalStorage.saveData(
      key: 'firstScreenData',
      data: data,
    ); // Save to storage
  }

  // Retrieve first-screen data
  Map<String, dynamic> getStoredFirstScreenData() {
    return LocalStorage.getData(key: 'firstScreenData') ?? {};
  }

  // API call for sign-up
  Future<void> signUp(Map<String, dynamic> secondScreenData) async {
    final url = Api.signUp;
    final requestBody = {
      ...firstScreenData,
      ...secondScreenData,
    };

    // Remove null or empty fields
    requestBody.removeWhere(
        (key, value) => value == null || value == '' || value == 0);

    print('================> $requestBody <====================');

    try {
      final response = await BaseClient.postRequest(
        api: url,
        body: jsonEncode(requestBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      // Handle response
      final responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        final userId = responseData['data']['athlete']['_id'];
        final email = requestBody['email'];

        if (userId != null) {
          LocalStorage.saveData(key: 'userId', data: userId);

          Get.snackbar('Success', 'Account created successfully!');
          Get.offAll(() => VerifyYourEmailView(
                email: email,
              ));
        }
      }
    } catch (e) {
      // Handle errors
      print('SignUp Error: $e');
      Get.snackbar('Error', 'Failed to sign up. Please try again.');
    }
  }

  ///send otp
  Future sentOtp({
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
            api: Api.sentOtp,
            body: jsonEncode(map),
            headers: headers
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        kSnackBar(message: message, bgColor: AppColors.green);

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

  /// **Verify OTP API Call**
  Future<void> verifyEmail({
    required String email,
    required String otp,
    required bool verifyEmail,
  }) async {
    final url = Api.otpVerify;
    final requestBody = {
      "email": email,
      "otp": otp,
      "verify_email": verifyEmail
    };

    try {
      final response = await BaseClient.postRequest(
        api: url,
        body: jsonEncode(requestBody),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      final responseData = await BaseClient.handleResponse(response);

      if (responseData != null && responseData['success'] == true) {
        Get.snackbar('Success', 'OTP verified successfully!');
        Get.offAll(() => SignInView());
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      log('OTP Verification Error: $e');
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
    }
  }
}
