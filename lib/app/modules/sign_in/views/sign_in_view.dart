import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/home/views/home_view.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../../forgot_password/views/forgot_password_view.dart';
import '../../sign_up/views/sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Sign In',
          style: h2.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              sh50,
              Image.asset(AppImages.logo),
              sh30,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email address', style: h5),
                  sh8,
                  CustomTextField(
                    controller: emailTEController,
                    hintText: 'roy@roy.com',
                  ),
                  sh30,
                  Text('Password', style: h5),
                  sh10,
                  CustomTextField(
                    controller: passwordTEController,
                    sufIcon: Image.asset(
                      AppImages.eyeClose,
                      scale: 4,
                    ),
                    hintText: '**********',
                  ),
                ],
              ),
              sh14,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Image.asset(
                          isChecked ? AppImages.checkboxFilled : AppImages.checkbox,
                          scale: 4,
                        ),
                      ),
                      sw12,
                      Text(
                        'Remember me',
                        style: h5.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordView());
                    },
                    child: Text(
                      'Forgot the password?',
                      style: h5.copyWith(color: AppColors.mainColor),
                    ),
                  ),
                ],
              ),
              sh30,
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Get.to(()=> HomeView());
                },
              ),
              sh16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Divider()),
                  sw10,
                  Text(
                    'Or sign in with',
                    style: h4.copyWith(color: AppColors.greyDark),
                  ),
                  sw10,
                  const Expanded(child: Divider()),
                ],
              ),
              sh10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account? ',
                    style: h5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                            () => const SignUpView(),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: h5.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
