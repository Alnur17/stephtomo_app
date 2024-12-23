import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/views/payment_success_view.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_textfelid.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final String selectedPlan = Get.arguments['plan'];
    final double selectedPrice = Get.arguments['price'];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back,scale: 4,),
        ),
        title: Text(
          'Payment Details',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh16,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.diamond,
                          scale: 4,
                        ),
                        sw16,
                        Text(
                          '$selectedPrice\$ / $selectedPlan',
                          style: h3.copyWith(color: AppColors.mainColor),
                        ),
                      ],
                    ),
                    sh8,
                    Text(
                      selectedPlan,
                      style: titleStyle,
                    ),
                    sh8,
                    Text(
                      'Billed monthly no trial',
                      style: subTitleStyle.copyWith(color: AppColors.black),
                    ),
                    sh8,
                    GestureDetector(
                      onTap: () {
                        Get.back(); // Allow user to go back to change the plan
                      },
                      child: Text(
                        'Edit Plan',
                        style: h4.copyWith(
                          color: AppColors.mainColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sh16,
              Text('Full name on card',style: h5),
              sh8,
              CustomTextField(
                hintText: 'Enter your full name',
              ),
              sh16,
              Text('Expired',style: h5),
              sh8,
              CustomTextField(
                hintText: 'MM/YYYY',
              ),
              sh16,
              Text('Card Number',style: h5),
              sh8,
              CustomTextField(
                hintText: '01234 XXXX XXXX XXXX',
              ),
              sh16,
              Text('CVV',style: h5),
              sh8,
              CustomTextField(
                hintText: '•••',
                //isPassword: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 30),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Cancel',
                onPressed: () {},
                backgroundColor: AppColors.transparent,
                borderColor: AppColors.mainColor,
                isTextStyleSelected: true,
              ),
            ),
            sw16,
            Expanded(
              child: CustomButton(
                text: 'Proceed',
                onPressed: () {
                  Get.to(()=> PaymentSuccessView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
