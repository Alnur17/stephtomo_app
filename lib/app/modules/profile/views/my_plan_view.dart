import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/my_plan_controller.dart';

class MyPlanView extends StatefulWidget {

  const MyPlanView({super.key});

  @override
  State<MyPlanView> createState() => _MyPlanViewState();
}

class _MyPlanViewState extends State<MyPlanView> {
  final MyPlanController myPlanController = Get.put(MyPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('My Plan'), centerTitle: true,backgroundColor: AppColors.white,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sh30,
              Text('My Current Plan', style: h3),
              sh16,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Column(
                  children: [
                    Text(myPlanController.currentPlan.value, style: titleStyle),
                    sh8,
                    Text('\$${myPlanController.currentPrice.value} / ${myPlanController.currentPlan.value}', style: h3),
                    sh8,
                    Text(
                      myPlanController.currentPlan.value == "Monthly" ? '15 message send' : 'Unlimited message send',
                      style: subTitleStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}