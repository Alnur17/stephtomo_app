import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:stephtomo_app/app/modules/profile/controllers/profile_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/api.dart';
import '../model/edit_profile_model.dart';

class EditProfileController extends GetxController {
  var profileController = Get.put(ProfileController());
  var isLoading = false.obs;
  var editProfileData = Rxn<Data>();
  var profileImage = Rxn<File>();
  var profileName = ''.obs;
  var email = ''.obs;
  File? selectedImage;

  Future<void> updateProfile({
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
      isLoading.value = true;

      String userId = editProfileData.value?.id ?? "";
      if (userId.isEmpty) {
        kSnackBar(message: "User ID not found", bgColor: AppColors.orange);
        isLoading.value = false;
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Api.editProfile));

      String token = LocalStorage.getData(key: AppConstant.token);
      request.headers.addAll({
        'Authorization': "Bearer, $token",
        'Content-Type': 'multipart/form-data',
      });

      // ✅ If a new image is selected, add it to the request
      if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath('image', selectedImage!.path));
      }

      // ✅ Construct payload
      Map<String, dynamic> payload = {
        "name": name,
        "height": height,
        "primary_position": primaryPosition,
        "club_team": clubTeam,
        "club_coach_name": clubCoachName,
        "club_coach_email": clubCoachEmail,
        "address": address,
      };

      // ✅ If no new image is selected, send existing image URL
      if (selectedImage == null && editProfileData.value?.profileImage != null) {
        payload["profile_image"] = editProfileData.value!.profileImage;
      }

      request.fields['payload'] = jsonEncode(payload);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseData);

      debugPrint("API Response: $decodedResponse"); // ✅ Debug API response

      if (response.statusCode == 200) {
        kSnackBar(message: "Profile updated successfully", bgColor: AppColors.green);

        // ✅ Parse response using EditProfileModel
        EditProfileModel updatedProfile = EditProfileModel.fromJson(jsonDecode(responseData));

        // ✅ Update local profile data
        if (updatedProfile.data != null) {
          editProfileData.value = updatedProfile.data;
          profileName.value = updatedProfile.data!.name ?? "User Name";
          email.value = updatedProfile.data!.email ?? "example@gmail.com";

          // ✅ If an image was updated, set it as the new profile image
          if (selectedImage != null) {
            profileImage.value = selectedImage!;
          }
        }

        await profileController.fetchProfile(); // Refresh user data
      } else {
        kSnackBar(
          message: decodedResponse['message'] ?? "Failed to update profile",
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(message: "Error updating profile: $e", bgColor: AppColors.orange);
      debugPrint("Update Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      profileImage.value = selectedImage; // Update observable
      update();
    }
  }
}
