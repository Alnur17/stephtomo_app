import 'package:flutter/material.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../controllers/subscription_plan_controller.dart';

// New PlanTile Widget
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
    return Container(
      padding: const EdgeInsets.all(16),
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
                title,
                style: titleStyle.copyWith(color: AppColors.mainColor),
              ),
              sh8,
              Text(
                title == "Monthly" ? '15 message send' : 'Unlimited message send',
                style: subTitleStyle.copyWith(color: AppColors.mainColor),
              ),
            ],
          ),
          Text(
            '\$$price / $title',
            style: h3.copyWith(color: AppColors.mainColor),
          ),
        ],
      ),
    );
  }
}