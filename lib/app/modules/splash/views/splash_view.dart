import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/dashboard/views/dashboard_view.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../onboarding/views/onboarding_view.dart';

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
      return chooseScreen();
    });
  }

  chooseScreen() {
    var userToken = LocalStorage.getData(key: AppConstant.token);

    if (userToken != null) {
      Get.offAll(
        () => DashboardView(),
        transition: Transition.rightToLeft,
      );
    } else {
      Get.offAll(
        () => OnboardingView(),
        transition: Transition.rightToLeft,
      );
    }

    // if (userToken != null) {
    //   final company = getCompanyFromToken(userToken);
    //   print(userToken);
    //   if(company == "companyOne"){
    //     Get.offAll(() =>  DashboradOneView(),transition: Transition.fade);
    //   }else{
    //     Get.offAll(() =>  DashboradTwoView(),transition: Transition.fade);
    //   }
    // } else {
    //   Get.offAll(() =>  CompanyView(),transition: Transition.fade);
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(AppImages.splashLogo),
      ),
    );
  }
}
