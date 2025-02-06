import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_email_model.dart';

class AllEmailController extends GetxController {
  var emailData = <Datum>[].obs; // Use Datum list instead of dynamic list
  var isLoading = true.obs;

  Future<void> loadEmails() async {
    try {
      String apiUrl = Api.allEmail;
      String token = LocalStorage.getData(key: AppConstant.token);
      var headers = {
        'Authorization': 'Bearer, $token',
      };

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      print('Response body: ${response.body}');  // Log the raw response body

      if (response.statusCode == 200) {
        var emails = AllEmailModel.fromJson(json.decode(response.body));  // Parse response into AllEmailModel

        if (emails.data?.data != null) {
          emailData.value = emails.data!.data; // Use parsed data
          print('Email data loaded: ${emailData.length}');  // Log length of data

          if (emailData.isEmpty) {
            Get.snackbar("No Emails", "The email list is empty", backgroundColor: Colors.red);
          }
        } else {
          throw "No email data found";
        }

        isLoading.value = false;
      } else {
        throw "Error fetching emails, status code: ${response.statusCode}";
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
