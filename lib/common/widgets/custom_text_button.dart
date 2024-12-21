import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final double height;
  final double width;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.mainColor,
    this.borderColor = AppColors.mainColor,
    this.textStyle,
    this.height = 25,
    this.width = 75,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: Text(
          label,
          style: textStyle ??
              h6.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
