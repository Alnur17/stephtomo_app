import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/sign_up/views/sign_up_two_view.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';
import 'package:stephtomo_app/common/widgets/custom_textfelid.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Sign Up',
          style: h2.copyWith(
            color: AppColors.mainColor,
          ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
              ),
              sh16,
              Divider(
                thickness: 1.3,
                color: AppColors.black,
                indent: Get.width * 0.35,
                endIndent: Get.width * 0.35,
              ),
              Text(
                'Registration',
                style: h4.copyWith(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              sh5,
              Text(
                '(1 of 2 )',
                style: h4.copyWith(
                  fontWeight: FontWeight.w500,
                ),
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
                    'Grad year',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your grad year',
                  ),
                  sh16,
                  Text(
                    'GPA',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your GPA',
                  ),
                  sh16,
                  Text(
                    'Sports',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Drop down here',
                    sufIcon: Image.asset(
                      AppImages.arrowDown,
                      scale: 4,
                    ),
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
                    'Secondary position',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your secondary position',
                  ),
                  sh16,
                  Text(
                    'Are you ?',
                    style: h5,
                  ),
                  sh16,
                  Text(
                    'Are you ?',
                    style: h5,
                  ),
                  sh16,
                  Text(
                    'Are you ?',
                    style: h5,
                  ),
                ],
              ),
              sh40,
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  Get.to(() => SignUpTwoView());
                },
              ),
              sh24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: h5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignInView());
                    },
                    child: Text(
                      'Sign In',
                      style: h5.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}
