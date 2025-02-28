import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/sent_email_model.dart';
import '../model/received_email_model.dart';

class AllEmailController extends GetxController {
  var sentEmailData = <dynamic>[].obs; // Storing
  var receivedEmailData = <dynamic>[].obs; // Storing
  var isLoadingSent = true.obs;
  var isLoadingReceived = true.obs;

  /// Fetch Sent Emails
  Future<void> fetchSentEmails() async {
    isLoadingSent.value = true;
    try {
      String apiUrl = Api.sentEmail;
      String token = LocalStorage.getData(key: AppConstant.token);

      if (token.isEmpty) throw "Authorization token is missing.";

      var headers = {'Authorization': 'Bearer, $token'};

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        var emails = SentEmailModel.fromJson(responseBody);

        if (emails.data?.data.isNotEmpty ?? false) {
          sentEmailData.assignAll(emails.data!.data);
        } else {
          sentEmailData.clear();
          Get.snackbar("No Sent Emails", "The sent email list is empty",
              backgroundColor: Colors.orange);
        }
      } else {
        throw responseBody["message"] ?? "Error fetching sent emails";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoadingSent.value = false;
    }
  }


  /// Fetch Received Emails
  Future<void> fetchReceivedEmails() async {
    isLoadingReceived.value = true;
    try {
      String apiUrl = Api.receivedEmail;
      String token = LocalStorage.getData(key: AppConstant.token);

      if (token.isEmpty) throw "Authorization token is missing.";

      var headers = {'Authorization': 'Bearer, $token'};

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode == 200) {
        var emails = ReceivedEmailModel.fromJson(json.decode(response.body));

        if (emails.data?.data != null && emails.data!.data.isNotEmpty) {
          receivedEmailData.value = emails.data!.data;
        } else {
          receivedEmailData.clear();
          Get.snackbar("No Received Emails", "The received email list is empty", backgroundColor: Colors.orange,snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        throw "Error fetching received emails, status code: ${response.statusCode}";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoadingReceived.value = false;
    }
  }
}


