import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/app/modules/sign_up/views/sign_up_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/base_client.dart';
import '../model/profile_model.dart';
import 'package:mime/mime.dart';


class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Rxn<Data>();
  var profileImage = Rxn<File>();
  var profileName = ''.obs;
  var email = ''.obs;
  var selectedImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      String apiUrl = Api.profile;

      debugPrint("Fetching Profile Data...");
      String token = LocalStorage.getData(key: AppConstant.token);
      var headers = {
        'Content-Type': "application/json",
        "Authorization": "Bearer, $token"
      };

      var response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = await BaseClient.handleResponse(response);
        ProfileModel profileModel = ProfileModel.fromJson(jsonResponse);

        if (profileModel.data != null) {
          profileData.value = profileModel.data;
          profileName.value = profileModel.data!.name ?? "User Name";
          email.value = profileModel.data!.email ?? "example@gmail.com";
        }
      } else {
        kSnackBar(
          message: "Failed to load profile data",
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      kSnackBar(
        message: "Error fetching profile: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    //required BuildContext context,
    required String name,
    required String height,
    required String primaryPosition,
    required String clubTeam,
    required String clubCoachName,
    required String clubCoachEmail,
    required String address,
  })
  async {
    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      if (token.isEmpty) {
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Api.editProfile));

      request.headers.addAll({
        'Authorization': "Bearer, $token",
        'Content-Type': 'multipart/form-data',
      });

      // Add JSON payload as text
      Map<String, dynamic> payload = {
        "name": name,
        "height": height,
        "primary_position": primaryPosition,
        "club_team": clubTeam,
        "club_coach_name": clubCoachName,
        "club_coach_email": clubCoachEmail,
        "address": address,
      };

      request.fields['payload'] = jsonEncode(payload);

      // Handle Image Upload
      if (selectedImage.value != null) {
        String imagePath = selectedImage.value!.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      try {
        var decodedResponse = json.decode(responseData);

        if (response.statusCode == 200) {
          kSnackBar(
              message: "Profile updated successfully",
              bgColor: AppColors.green);

          await fetchProfile();
          update();
          if (Get.context != null) {
            Navigator.pop(Get.context!);
          }
          //Navigator.pop(context); // sometimes it get some issue
        } else {
          kSnackBar(
            message: decodedResponse['message'] ?? "Failed to update profile",
            bgColor: AppColors.orange,
          );
        }
      } catch (decodeError) {
        kSnackBar(
            message: "Invalid response format", bgColor: AppColors.orange);
        debugPrint("Response Error: $decodeError");
      }
    } catch (e) {
      kSnackBar(
          message: "Error updating profile: $e", bgColor: AppColors.orange);
      debugPrint("Update Error: $e");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      profileImage.value = selectedImage.value;
      debugPrint("Image Selected: ${pickedFile.path}");
      update();
    }
  }

  Future<void> deleteProfile() async {
    try {
      var response = await BaseClient.deleteRequest(api: Api.deleteProfile);

      if (response.statusCode == 200) {
        kSnackBar(
            message: "Profile deleted successfully", bgColor: AppColors.green);
        LocalStorage.removeData(key: AppConstant.token);
        Get.offAll(() => SignUpView());
      } else {
        var responseData = await BaseClient.handleResponse(response);
        kSnackBar(
            message: responseData['message'] ?? "Failed to delete profile",
            bgColor: AppColors.orange);
      }
    } catch (e) {
      kSnackBar(
          message: "Error deleting profile: $e", bgColor: AppColors.orange);
      debugPrint("Delete Error: $e");
    }
  }
}
