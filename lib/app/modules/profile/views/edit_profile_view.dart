import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileController.setTempImage(File(pickedFile.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sh20,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profileController.tempImage != null
                        ? FileImage(profileController.tempImage!)
                    as ImageProvider
                        : profileController.profileImage.value != null
                        ? FileImage(profileController.profileImage.value!)
                    as ImageProvider
                        : AssetImage(AppImages.profileAvatarPlaceholder),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: AppColors.blueLight),
                        child: Image.asset(
                          AppImages.editProfile,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sh16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your name',
                  ),
                  sh16,
                  Text(
                    'Height',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your height',
                  ),
                  sh16,
                  Text(
                    'Primary position',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your primary position',
                  ),
                  sh16,
                  Text(
                    'Club team',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter here',
                  ),
                  sh16,
                  Text(
                    'Club coach name',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter here',
                  ),
                  sh16,
                  Text(
                    'Club coach email',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter here',
                  ),
                  sh16,
                  Text(
                    'Address',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your address',
                  ),
                ],
              ),
              sh20,
              CustomButton(
                text: 'Update',
                onPressed: () {
                  profileController.confirmProfileImage();
                  Get.back();
                },
              ),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}
