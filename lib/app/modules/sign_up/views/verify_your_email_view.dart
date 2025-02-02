import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stephtomo_app/app/modules/sign_up/controllers/sign_up_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';

class VerifyYourEmailView extends GetView {
  final String email;

  VerifyYourEmailView({super.key, required this.email});

  final TextEditingController otpTEController = TextEditingController();

  final SignUpController signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Email verification',
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
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Image.asset(
                  AppImages.emailVerify,
                  scale: 4,
                ),
                sh16,
                Text(
                  'Verify Code',
                  style: h2,
                ),
                sh16,
                Text(
                  'Please enter the 6 digit code that was sent to $email ',
                  style: h5,
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   'roy@gmail.com',
                //   style: h3.copyWith(color: AppColors.creamColor),
                // ),
                sh30,
                PinCodeTextField(
                  controller: otpTEController,
                  length: 6,
                  // Set the length to 6
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 55,
                    fieldWidth: 50,
                    activeColor: AppColors.white,
                    activeFillColor: AppColors.greyLight,
                    inactiveColor: AppColors.grey,
                    inactiveFillColor: AppColors.white,
                    selectedColor: AppColors.mainColor,
                    selectedFillColor: AppColors.greyLight,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: AppColors.transparent,
                  cursorColor: AppColors.blue,
                  enablePinAutofill: true,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    // Handle completion
                  },
                  onChanged: (value) {
                    // Handle value change
                  },
                  beforeTextPaste: (text) {
                    log("Allowing to paste $text");
                    return true;
                  },
                  appContext: context,
                ),

                sh30,
                Text(
                  'Resend code',
                  style: h4.copyWith(color: AppColors.mainColor),
                ),
                Divider(
                  color: AppColors.mainColor,
                  indent: Get.width * 0.3,
                  endIndent: Get.width * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
        child: CustomButton(
          text: 'Verify OTP',
          onPressed: () {
            String otp = otpTEController.text.trim();
            if (otp.length == 6) {
              signupController.verifyOtp(email: email, otp: otp);
            } else {
              Get.snackbar('Error', 'Please enter a valid 6-digit OTP.');
            }
          },
        ),
      ),
    );
  }
}
