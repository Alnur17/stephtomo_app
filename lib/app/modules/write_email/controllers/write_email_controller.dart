import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../../../data/api.dart';
import '../../../data/dummy_data.dart';

import 'package:mime/mime.dart';

class WriteEmailController extends GetxController {
  var checkbox = List.generate(data.length, (index) => false.obs).obs;

  void markAll() {
    bool allSelected = checkbox.every((item) => item.value);

    for (var check in checkbox) {
      check.value = !allSelected;
    }
  }

  void toggleCheckbox(int index) {
    checkbox[index].value = !checkbox[index].value;
  }

  var emailController = TextEditingController();
  var subjectController = TextEditingController();
  var messageController = TextEditingController();

  var recipients = [].obs;  // List of recipients from API
  var selectedRecipient = ''.obs;

  var profileData = {}.obs;  // Profile data from API
  var reminderDate = Rxn<DateTime>(); // Nullable DateTime

  @override
  void onInit() {
    fetchProfileData();
    fetchRecipients();
    super.onInit();
  }

  /// Fetch user profile data
  void fetchProfileData() async {
    var data = await EmailService.fetchProfile();
    if (data != null) {
      profileData.value = data;
    }
  }

  /// Fetch recipients list
  void fetchRecipients() async {
    var data = await EmailService.fetchRecipients();
    if (data != null) {
      recipients.assignAll(data);
    }
  }

  /// Select a reminder date
  Future<void> pickReminderDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: reminderDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      reminderDate.value = pickedDate;
    }
  }

  /// Validate fields before sending an email
  bool validateFields(File? selectedVideo) {
    if (selectedRecipient.isEmpty) {
      Get.snackbar("Error", "Please select a recipient", backgroundColor: Colors.red);
      return false;
    }
    if (subjectController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a subject", backgroundColor: Colors.red);
      return false;
    }
    if (messageController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a message", backgroundColor: Colors.red);
      return false;
    }
    if (selectedVideo == null) {
      Get.snackbar("Error", "Please select a video", backgroundColor: Colors.red);
      return false;
    }
    if (reminderDate.value == null) {
      Get.snackbar("Error", "Please select a reminder date", backgroundColor: Colors.red);
      return false;
    }
    return true;
  }

  /// Send email via API
  Future<bool> sendEmail(File videoFile) async {
    return await EmailService.sendEmail(
      selectedRecipient.value,
      subjectController.text,
      messageController.text,
      reminderDate.value != null ? DateFormat("yyyy-MM-dd").format(reminderDate.value!) : null,
      videoFile,
    );
  }
}


// outside the controller
class EmailService {
  /// Fetch user profile summary from API
  static Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse(Api.profile));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching profile: $e");
      return null;
    }
  }

  /// Fetch email recipients list from API
  static Future<List<dynamic>?> fetchRecipients() async {
    try {
      final response = await http.get(Uri.parse("${Api.baseUrl}/email/recipients"));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching recipients: $e");
      return null;
    }
  }

  /// Send email with video attachment
  static Future<bool> sendEmail(
      String to, String subject, String message, String? reminderDate, File videoFile) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(Api.writeEmail));

      var payload = {
        "to": [to],
        "subject": subject,
        "message": message,
      };

      if (reminderDate != null) {
        payload["reminder_date"] = reminderDate;
      }

      request.fields["payload"] = jsonEncode(payload);

      var videoStream = http.MultipartFile.fromBytes(
        'video',
        videoFile.readAsBytesSync(),
        filename: basename(videoFile.path),
        contentType: MediaType.parse(lookupMimeType(videoFile.path) ?? "video/mp4"),
      );

      request.files.add(videoStream);
      var response = await request.send();

      return response.statusCode == 200;
    } catch (e) {
      print("Error sending email: $e");
      return false;
    }
  }
}

