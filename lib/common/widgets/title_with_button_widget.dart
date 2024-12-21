import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import 'custom_text_button.dart';
class TitleWithButtonWidget extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final TextStyle? titleTextStyle;
  final double height;
  final double width;

  const TitleWithButtonWidget({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.onPressed,
    this.backgroundColor = AppColors.mainColor,
    this.borderColor = AppColors.mainColor,
    this.textStyle,
    this.titleTextStyle,
    this.height = 22,
    this.width = 75,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleTextStyle ??
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        CustomTextButton(
          label: buttonLabel,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          textStyle: textStyle,
          height: height,
          width: width,
        )
      ],
    );
  }
}
