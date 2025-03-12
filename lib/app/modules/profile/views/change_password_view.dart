import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/controllers/settings_controller.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../../forgot_password/views/forgot_password_view.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  SettingsController settingsController = Get.put(SettingsController());

  TextEditingController currentPassTEController = TextEditingController();
  TextEditingController newPassTEController = TextEditingController();
  TextEditingController confirmPassTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Change Password',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh40,
            Text('Current Password'),
            sh8,
            CustomTextField(
              controller: currentPassTEController,
              hintText: 'Current Password',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            Text('New Password'),
            sh8,
            CustomTextField(
              controller: newPassTEController,
              hintText: 'New Password',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            Text('Confirm Password'),
            sh8,
            CustomTextField(
              controller: confirmPassTEController,
              hintText: 'Confirm Password',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            GestureDetector(
              onTap: () {
                Get.to(() => ForgotPasswordView());
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Forgot the password?',
                  style: h5.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 150),
        child: Obx(
          () => settingsController.isLoading.value == true
              ? CustomLoader(
                  color: AppColors.white,
                )
              : CustomButton(
                  text: "Save",
                  onPressed: () {
                    if (newPassTEController.text ==
                        confirmPassTEController.text) {
                      settingsController.changePassword(
                        currentPassword: currentPassTEController.text,
                        newPassword: newPassTEController.text,
                      );
                    } else {
                      kSnackBar(
                          message: "Password not match",
                          bgColor: AppColors.mainColor);
                    }
                  },
                ),
        ),
      ),
    );
  }
}
