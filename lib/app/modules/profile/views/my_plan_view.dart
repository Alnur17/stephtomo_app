import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
        ),
        title: Text('My Plan', style: titleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () => myPlanController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sh30,
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
                    Text(
                      myPlanController.packageName.value,
                      style: titleStyle,
                    ),
                    sh8,
                    Text(
                      '\$${myPlanController.price.value}',
                      style: h3,
                    ),
                    sh8,
                    if (myPlanController.packageName.value != 'Free Trial' &&
                        myPlanController.endDate.value.isNotEmpty)
                      Text(
                        'Ends on: ${myPlanController.endDate.value}',
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