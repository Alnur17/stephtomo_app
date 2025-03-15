import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stephtomo_app/app/modules/forgot_password/controllers/forgot_password_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/email_verification_controller.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
  final String email;

  EmailVerificationView({super.key, required this.email});

  final TextEditingController otpTEController = TextEditingController();

  final EmailVerificationController emailVerificationController =
      Get.put(EmailVerificationController());
  final ForgotPasswordController forgotPasswordController = Get.find();

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
                Obx(() {
                  return forgotPasswordController.countdown.value > 0
                      ? Text(
                    'Resend code in ${forgotPasswordController.countdown.value}s',
                    style: h3,
                  )
                      : GestureDetector(
                    onTap: forgotPasswordController.countdown.value == 0 ? () {
                      forgotPasswordController.forgotPassword(email: email);
                    } : null,
                    child: Text(
                      'Resend code',
                      style: h4.copyWith(
                        color: AppColors.mainColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.mainColor,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  );
                }),
                // GestureDetector(
                //   onTap: () {
                //     forgotPasswordController.forgotPassword(email: email);
                //   },
                //   child: Text(
                //     'Resend code',
                //     style: h4.copyWith(
                //       color: AppColors.mainColor,
                //       decoration: TextDecoration.underline,
                //       decorationColor: AppColors.mainColor,
                //       decorationThickness: 2,
                //       decorationStyle: TextDecorationStyle.dashed,
                //     ),
                //   ),
                // ),
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
            emailVerificationController.verifyOtp(
              email: email,
              otp: otpTEController.text,
            );
          },
        ),
      ),
    );
  }
}
