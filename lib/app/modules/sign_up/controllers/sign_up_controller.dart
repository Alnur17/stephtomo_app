import 'dart:convert';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/app/modules/sign_up/views/verify_your_email_view.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/base_client.dart';

class SignUpController extends GetxController {
  var firstScreenData = {}.obs; // Reactive state for first-screen data

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

    // Validate requestBody
    if (requestBody.values.any((value) => value == null || value == '')) {
      Get.snackbar('Error', 'Please fill all required fields.');
      return;
    }

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
        final token = responseData['data']?['accessToken'];
        final userId = responseData['data']?['athlete']?['_id'];

        if (token != null && userId != null) {
          // Save token and user info using LocalStorage
          LocalStorage.saveData(key: 'token', data: token);
          LocalStorage.saveData(key: 'userId', data: userId);

          // Success notification and navigate to dashboard
          Get.snackbar('Success', 'Account created successfully!');
          Get.offAll(() =>
              VerifyYourEmailView(email:,)); // Update route as per your setup
        } else {
          Get.snackbar('Error', 'Invalid response from server.');
        }
      }
    } catch (e) {
      // Handle errors
      print('SignUp Error: $e');
      Get.snackbar('Error', 'Failed to sign up. Please try again.');
    }
  }
}
