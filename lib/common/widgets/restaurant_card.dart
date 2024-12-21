import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import 'custom_button.dart';

class RestaurantCard extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const RestaurantCard({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 205,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              scale: 4,
              fit: BoxFit.cover,
            ),
            sh10,
            CustomButton(
              height: 34,
              backgroundColor: AppColors.creamColor,
              onPressed: onButtonPressed,
              text: buttonText,
              textStyle: h6.copyWith(color: AppColors.white,fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
