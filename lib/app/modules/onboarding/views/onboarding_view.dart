import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/sign_in/views/sign_in_view.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.black.withOpacity(0.0),
                AppColors.black.withOpacity(1.0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 30,
            child: Column(
              children: [
                Text(
                  'Find top sports Collage Recruiting',
                  style: h2.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                sh12,
                Text(
                  'Discover the best institutions for aspiring athletes to excel both academically and athletically.',
                  style: h6.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                sh30,
                CustomButton(
                  backgroundColor: AppColors.white,
                  textStyle: h3.copyWith(color: AppColors.black),
                  text: 'Get Started',
                  onPressed: () {
                    Get.to(()=> SignInView());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
