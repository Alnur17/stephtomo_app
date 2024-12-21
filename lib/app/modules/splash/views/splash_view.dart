import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../onboarding/views/onboarding_view.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => OnboardingView(),
        transition: Transition.fade,
        duration: Duration(seconds: 2),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icons/splash logo.png'),
      ),
    );
  }
}
