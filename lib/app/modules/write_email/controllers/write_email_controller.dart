//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
//
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../data/api.dart';
// import '../../profile/controllers/profile_controller.dart';
//
// class WriteEmailController extends GetxController {
//   final ProfileController profileController = Get.put(ProfileController());
//   // Manage the selected checkboxes (for selecting recipients)
//   var checkbox = List.generate(10, (index) => false.obs).obs;
//
//   void markAll() {
//     bool allSelected = checkbox.every((item) => item.value);
//     for (var check in checkbox) {
//       check.value = !allSelected;
//     }
//   }
//
//   void toggleCheckbox(int index) {
//     checkbox[index].value = !checkbox[index].value;
//   }
//
//   // Controllers for input fields
//   var emailController = TextEditingController();
//   var subjectController = TextEditingController();
//   var messageController = TextEditingController();
//
//   var reminderDate = Rxn<DateTime>(); // Nullable DateTime
//
//   /// Open date picker for selecting a reminder date
//   Future<void> pickReminderDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: reminderDate.value ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null) {
//       reminderDate.value = pickedDate;
//     }
//   }
//
//   /// Pick a video file from gallery
//   Future<File?> pickVideo() async {
//     final picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null; // Return null if no video is selected
//   }
//
//   /// Validate email form fields
//   bool validateFields(File? selectedVideo) {
//     if (emailController.text.isEmpty) {
//       Get.snackbar("Error", "Please enter a recipient email.", backgroundColor: Colors.red);
//       return false;
//     }
//     if (subjectController.text.isEmpty) {
//       Get.snackbar("Error", "Please enter a subject.", backgroundColor: Colors.red);
//       return false;
//     }
//     if (messageController.text.isEmpty) {
//       Get.snackbar("Error", "Please enter a message.", backgroundColor: Colors.red);
//       return false;
//     }
//     if (reminderDate.value == null) {
//       Get.snackbar("Error", "Please select a reminder date.", backgroundColor: Colors.red);
//       return false;
//     }
//
//     return true;
//   }
//
//   /// Send email with an optional video attachment
//   Future<bool> sendEmail(
//       List<String> to, String subject, String message, String? reminderDate, File? videoFile,) async {
//     try {
//       String token = LocalStorage.getData(key: AppConstant.token);
//
//       if (token.isEmpty) {
//         print("Error: No token found!");
//         Get.snackbar("Error", "No token found. Please log in.", backgroundColor: Colors.red);
//         return false;
//       }
//
//       var headers = {
//         "Authorization": "Bearer, $token",
//       };
//
//       var request = http.MultipartRequest("POST", Uri.parse(Api.writeEmail));
//       request.headers.addAll(headers);
//
//        //var coachNumber = profileController.profileData.value?.clubCoachPhone ?? '';
//
//
//       var payload = {
//         "to": to,
//         "subject": subject,
//         "body": message,
//         "signature": {
//           "name": profileController.profileData.value?.name ?? "Unknown",
//           "grad_year": profileController.profileData.value?.gradYear ?? 0,
//           "gpa": profileController.profileData.value?.gpa ?? 0.0,
//           "sport": profileController.profileData.value?.sport ?? "Unknown",
//           "height": profileController.profileData.value?.height ?? "Unknown",
//           "primary_position": profileController.profileData.value?.primaryPosition ?? "Unknown",
//           "club_team": profileController.profileData.value?.clubTeam ?? "Unknown",
//           "club_coach": profileController.profileData.value?.clubCoachName ?? "Unknown",
//           "club_coach_number": profileController.profileData.value?.clubCoachPhone.toString() ?? "Unknown",
//           "club_coach_email": profileController.profileData.value?.clubCoachEmail ?? "Unknown"
//         }
//       };
//
//       request.fields["payload"] = jsonEncode(payload);
//
//       if (videoFile != null) {
//         var mimeType = lookupMimeType(videoFile.path) ?? "video/mp4";
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'video',
//             await videoFile.readAsBytes(),
//             filename: basename(videoFile.path),
//             contentType: MediaType.parse(mimeType),
//           ),
//         );
//       }
//
//       debugPrint("Sending request to: ${Api.writeEmail}");
//       debugPrint("Payload: ${jsonEncode(payload)}");
//
//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();
//
//       debugPrint("Response Status Code: ${response.statusCode}");
//       debugPrint("Response Body: $responseBody");
//
//       if (response.statusCode == 201) {
//         Get.snackbar("Success", "Email sent successfully!", backgroundColor: Colors.green);
//         if(Get.context != null){
//           Navigator.pop(Get.context!);
//         }
//         return true;
//       } else {
//         Get.snackbar("Error", "Failed to send the email. ${response.reasonPhrase}",
//             backgroundColor: Colors.red);
//         return false;
//       }
//     } catch (e) {
//       debugPrint("Error sending email: $e");
//       Get.snackbar("Error", "An unexpected error occurred. Please try again.", backgroundColor: Colors.red);
//       return false;
//     }
//   }
//
//
// }
//


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../home/controllers/home_controller.dart'; // Import HomeController to access allSchool data

class WriteEmailController extends GetxController {
  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());

  var isLoading = false.obs;

  var checkbox = <RxBool>[].obs; // Dynamically sized based on allSchool length

  @override
  void onInit() {
    super.onInit();
    checkbox.value = List.generate(homeController.allSchool.length, (index) => false.obs);
  }

  void markAll() {
    bool allSelected = checkbox.every((item) => item.value);
    for (var check in checkbox) {
      check.value = !allSelected;
    }
  }

  void toggleCheckbox(int index) {
    checkbox[index].value = !checkbox[index].value;
  }

  // Controllers for input fields
  var emailController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();

  var reminderDate = Rxn<DateTime>(); // Nullable DateTime

  /// Open date picker for selecting a reminder date
  Future<void> pickReminderDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: reminderDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      reminderDate.value = pickedDate;
    }
  }

  /// Pick a video file from gallery
  Future<File?> pickVideo() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null; // Return null if no video is selected
  }

  /// Get selected recipients' emails
  List<String> getSelectedRecipients() {
    List<String> selectedEmails = [];
    for (int i = 0; i < checkbox.length; i++) {
      if (checkbox[i].value) {
        final coachData = homeController.allSchool[i];
        String? email = coachData.coach?.email;
        if (email != null && email.isNotEmpty) {
          selectedEmails.add(email);
        }
      }
    }
    return selectedEmails;
  }

  /// Validate email form fields
  bool validateFields(File? selectedVideo) {
    List<String> selectedRecipients = getSelectedRecipients();
    if (selectedRecipients.isEmpty) {
      Get.snackbar("Error", "Please select at least one recipient.", backgroundColor: Colors.red);
      return false;
    }
    if (subjectController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a subject.", backgroundColor: Colors.red);
      return false;
    }
    if (messageController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a message.", backgroundColor: Colors.red);
      return false;
    }
    // if (reminderDate.value == null) {
    //   Get.snackbar("Error", "Please select a reminder date.", backgroundColor: Colors.red);
    //   return false;
    // }
     return true;
  }

  /// Send email with an optional video attachment
  Future<bool> sendEmail(
      List<String> to,
      String subject,
      String message,
      String? reminderDate,
      File? videoFile,
      ) async {
    try {
      isLoading.value = true;

      String token = LocalStorage.getData(key: AppConstant.token);

      if (token.isEmpty) {
        print("Error: No token found!");
        Get.snackbar("Error", "No token found. Please log in.", backgroundColor: Colors.red);
        isLoading.value = false;
        return false;
      }

      var headers = {
        "Authorization": "Bearer, $token",
      };

      var request = http.MultipartRequest("POST", Uri.parse(Api.writeEmail));
      request.headers.addAll(headers);

      var payload = {
        "to": to,
        "subject": subject,
        "body": message,
        "signature": {
          "name": profileController.profileData.value?.name ?? "Unknown",
          "grad_year": profileController.profileData.value?.gradYear ?? 0,
          "gpa": profileController.profileData.value?.gpa ?? 0.0,
          "sport": profileController.profileData.value?.sport ?? "Unknown",
          "height": profileController.profileData.value?.height ?? "Unknown",
          "primary_position": profileController.profileData.value?.primaryPosition ?? "Unknown",
          "club_team": profileController.profileData.value?.clubTeam ?? "Unknown",
          "club_coach": profileController.profileData.value?.clubCoachName ?? "Unknown",
          "club_coach_number": profileController.profileData.value?.clubCoachPhone.toString() ?? "Unknown",
          "club_coach_email": profileController.profileData.value?.clubCoachEmail  ?? ""
        }
      };

      request.fields["payload"] = jsonEncode(payload);

      if (videoFile != null) {
        var mimeType = lookupMimeType(videoFile.path) ?? "video/mp4";
        request.files.add(
          http.MultipartFile.fromBytes(
            'video',
            await videoFile.readAsBytes(),
            filename: basename(videoFile.path),
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      debugPrint("Sending request to: ${Api.writeEmail}");
      debugPrint("Payload: ${jsonEncode(payload)}");

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: $responseBody");

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Email sent successfully!", backgroundColor: Colors.green);
        if (Get.context != null) {
          Navigator.pop(Get.context!);
        }
        isLoading.value = false;
        return true;
      } else {
        Get.snackbar("Error", "Failed to send the email. ${response.reasonPhrase}",
            backgroundColor: Colors.red);
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      debugPrint("Error sending email: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again.", backgroundColor: Colors.red);
      isLoading.value = false;
      return false;
    }
  }
}