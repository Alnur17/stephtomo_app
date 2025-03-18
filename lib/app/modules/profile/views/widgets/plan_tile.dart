import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../controllers/subscription_plan_controller.dart';

class PlanTile extends StatelessWidget {
  final String title;
  final double price;

  final SubscriptionPlanController controller;

  const PlanTile({
    super.key,
    required this.title,
    required this.price,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
        decoration: BoxDecoration(
          color: controller.selectedPlan.value == title
              ? AppColors.silver
              : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: controller.selectedPlan.value == title
                ? AppColors.mainColor
                : AppColors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: titleStyle.copyWith(color: AppColors.mainColor),
                ),
                // const SizedBox(height: 8),
                // Text(
                //   '$messages message${messages == 1 ? '' : 's'}',
                //   style: subTitleStyle.copyWith(color: AppColors.mainColor),
                // ),
              ],
            ),
            Text(
              '\$${price.toStringAsFixed(2)} / $title',
              style: h3.copyWith(color: AppColors.mainColor),
            ),
          ],
        ),
      ),
    );
  }
}