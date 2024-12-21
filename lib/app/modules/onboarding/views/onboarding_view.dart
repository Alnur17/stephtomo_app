import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.onboardingOne),
          sh12,
          Image.asset(AppImages.onboardingTwo),
          sh60,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              'Personalized Recipe Discovery',
              style: h1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sh16,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              'Tell us your food preferences and we\'ll serve you delicious recipes ideas.',
              style: h3,
              textAlign: TextAlign.center,
            ),

          ),
          sh40,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: CustomButton(
              text: 'Get Started',
              onPressed: () {
                Get.to(() => SignInView(), transition: Transition.rightToLeft,duration: Duration(milliseconds: 500),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
