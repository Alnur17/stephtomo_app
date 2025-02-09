import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/app/modules/sign_in/views/sign_in_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../data/base_client.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Rxn<Data>();
  var profileImage = Rxn<File>();
  var profileName = ''.obs;
  var email = ''.obs;
  File? selectedImage;

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

      var response = await BaseClient.getRequest(api: apiUrl,headers: headers);

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
    required String name,
    required String height,
    required String primaryPosition,
    required String clubTeam,
    required String clubCoachName,
    required String clubCoachEmail,
    required String address,
  }) async {
    try {
      String userId = profileData.value?.id ?? "";
      if (userId.isEmpty) {
        kSnackBar(message: "User ID not found", bgColor: AppColors.orange);
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Api.editProfile(userId)));

      String token = LocalStorage.getData(key: AppConstant.token);
      request.headers.addAll({
        'Authorization': "Bearer, $token",
        'Content-Type': 'multipart/form-data'
      });

      // Check if there's an existing image URL, use it if no new image is selected
      String existingImageUrl = profileData.value?.profileImage ?? "";

      request.fields['payload'] = jsonEncode({
        "name": name,
        "height": height,
        "primary_position": primaryPosition,
        "club_team": clubTeam,
        "club_coach_name": clubCoachName,
        "club_coach_email": clubCoachEmail,
        "address": address,
        "profile_image": existingImageUrl, // Ensure the image URL is included
      });

      // Only add a new image if it's selected
      if (selectedImage != null && selectedImage!.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', selectedImage!.path));
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        kSnackBar(message: "Profile updated successfully", bgColor: AppColors.green);

        // Fetch updated profile details
        await fetchProfile();
      } else {
        kSnackBar(message: decodedResponse['message'] ?? "Failed to update profile", bgColor: AppColors.orange);
      }
    } catch (e) {
      kSnackBar(message: "Error updating profile: $e", bgColor: AppColors.orange);
      debugPrint("Update Error: $e");
    }
  }

  Future<void> deleteProfile() async {
    try {
      String userId = profileData.value?.id ?? "";
      if (userId.isEmpty) {
        kSnackBar(message: "User ID not found", bgColor: AppColors.orange);
        return;
      }
      
      String apiUrl = Api.deleteProfile(userId);  
      
      var response = await BaseClient.deleteRequest(api: apiUrl);

      if (response.statusCode == 200) {
        kSnackBar(message: "Profile deleted successfully", bgColor: AppColors.green);
        String token = LocalStorage.removeData(key: AppConstant.token);
        print('User token $token');
        String userData = LocalStorage.removeData(key: AppConstant.userId);
        print('User data $userData');

        Get.offAll(()=> SignInView());
      } else {
        var responseData = await BaseClient.handleResponse(response);
        kSnackBar(message: responseData['message'] ?? "Failed to delete profile", bgColor: AppColors.orange);
      }
    } catch (e) {
      kSnackBar(message: "Error deleting profile: $e", bgColor: AppColors.orange);
      debugPrint("Delete Error: $e");
    }
  }


  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

}
