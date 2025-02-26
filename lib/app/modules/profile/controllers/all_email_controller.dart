// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
//
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../data/api.dart';
// import '../../../data/base_client.dart';
// import '../model/all_email_model.dart';
//
// class AllEmailController extends GetxController {
//   var emailData = <Datum>[].obs; // Use Datum list instead of dynamic list
//   var isLoading = true.obs;
//
//   Future<void> loadEmails() async {
//     try {
//       String apiUrl = Api.receivedEmail;
//       String token = LocalStorage.getData(key: AppConstant.token);
//       var headers = {
//         'Authorization': 'Bearer, $token',
//       };
//
//       final response = await BaseClient.getRequest(api: apiUrl, headers: headers);
//
//       print('Response body: ${response.body}');  // Log the raw response body
//
//       if (response.statusCode == 200) {
//         var emails = AllEmailModel.fromJson(json.decode(response.body));  // Parse response into AllEmailModel
//
//         if (emails.data?.data != null) {
//           emailData.value = emails.data!.data; // Use parsed data
//           print('Email data loaded: ${emailData.length}');  // Log length of data
//
//           if (emailData.isEmpty) {
//             Get.snackbar("No Emails", "The email list is empty", backgroundColor: Colors.red);
//           }
//         } else {
//           throw "No email data found";
//         }
//
//         isLoading.value = false;
//       } else {
//         throw "Error fetching emails, status code: ${response.statusCode}";
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
//     }
//   }
// }

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
  var sentEmailData = <dynamic>[].obs; // Store sent emails
  var receivedEmailData = <dynamic>[].obs; // Store received emails
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

        if (emails.data?.data?.isNotEmpty ?? false) {
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
          Get.snackbar("No Received Emails", "The received email list is empty", backgroundColor: Colors.orange);
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


