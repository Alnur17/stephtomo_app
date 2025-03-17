import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../common/app_images/app_images.dart';
import '../controllers/conditions_controller.dart';

class TermsOfConditionsView extends StatelessWidget {
  TermsOfConditionsView({super.key});

  final ConditionsController controller = Get.put(ConditionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Terms of Services',
          style: titleStyle,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: h4.copyWith(fontSize: 14, color: AppColors.red),
                ),
              );
            } else {
              return Html(
                data: controller.getTermsConditions(), // Render HTML content
                // style: {
                //   // Optional: Customize HTML rendering styles
                //   "body": Style(
                //     fontSize: FontSize(14),
                //     color: AppColors.black, // Adjust as per your theme
                //   ),
                // },
              );
            }
          }),
        ),
      ),
    );
  }
}
