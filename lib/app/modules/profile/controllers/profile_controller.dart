import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {

  var profileImage = Rxn<File>();
  File? tempImage;

  void setTempImage(File image) {
    tempImage = image;
  }

  void confirmProfileImage() {
    if (tempImage != null) {
      profileImage.value = tempImage;
      tempImage = null; // Clearing the temp image after update
    }
  }

  // void updateProfileImage(File image) {
  //   profileImage.value = image;
  // }
}