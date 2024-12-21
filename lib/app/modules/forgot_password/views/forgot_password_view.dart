import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/email_verification/views/email_verification_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Forgot Password',
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
                AppImages.forgotPass,
                scale: 4,
              ),
              sh30,
              Text(
                'Please enter your email address which was used to create your account  ',
                style: h5,
                textAlign: TextAlign.center,
              ),
              sh16,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Email',
                  style: h5,
                  textAlign: TextAlign.start,
                ),
              ),
              sh8,
              CustomTextField(
                hintText: 'Enter your email',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 100),
        child: CustomButton(
          text: 'Update',
          onPressed: () {
            Get.to(()=> EmailVerificationView());
          },
        ),
      ),
    );
  }
}
