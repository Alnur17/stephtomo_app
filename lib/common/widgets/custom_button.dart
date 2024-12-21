import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle, this.height = 54, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //padding: EdgeInsets.all(8),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: backgroundColor ??
              AppColors.mainColor, // Use custom color or default to mainColor
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? h3.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
