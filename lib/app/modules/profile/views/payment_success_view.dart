import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/views/profile_view.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';

class PaymentSuccessView extends GetView {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: CloseButton(
              onPressed: () {
                Get.offAll(()=> ProfileView());
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.silver),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.paymentSuccess,scale: 4,),
            sh30,
            Text('Payment Successful',style: h3.copyWith(fontSize: 22),),
            sh16,
            Text('Your payment was successful! Your account is currently under review; please wait for further updates.',style: h5,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
