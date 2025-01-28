import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
  final String email;

  //final String otp;
  CreateNewPasswordView( {super.key, required this.email,});

  final CreateNewPasswordController createNewPasswordController =
      Get.put(CreateNewPasswordController());
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Create New Password',
          style: appBarStyle,
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sh50,
              Image.asset(
                AppImages.createNewPass,
                scale: 4,
              ),
              sh30,
              Text(
                'Please create and enter a new password for your account',
                style: h5,
                textAlign: TextAlign.center,
              ),
              sh30,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Password',
                  style: h5,
                  textAlign: TextAlign.start,
                ),
              ),
              sh8,
              CustomTextField(
                controller: passwordTEController,
                hintText: 'Enter your password',
                sufIcon: Image.asset(
                  AppImages.eyeClose,
                  scale: 4,
                ),
              ),
              sh16,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Confirm Password',
                  style: h5,
                  textAlign: TextAlign.start,
                ),
              ),
              sh8,
              CustomTextField(
                controller: confirmPasswordTEController,
                hintText: 'Confirm your Password',
                sufIcon: Image.asset(
                  AppImages.eyeClose,
                  scale: 4,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
        child: CustomButton(
          text: 'Save',
          onPressed: () {
            if (passwordTEController.text == confirmPasswordTEController.text) {
              createNewPasswordController.forgotNewPassword(
                newPassword: passwordTEController.text,
                email: email,
              );
            }
          },
        ),
      ),
    );
  }
}
