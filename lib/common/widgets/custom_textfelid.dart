import 'package:flutter/material.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';

import '../app_text_style/styles.dart';

class CustomTextField extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Widget? sufIcon;
  final Widget? preIcon;
  final ValueChanged<String>? onChange;
  final double borderRadius;  // Add borderRadius as an optional parameter

  const CustomTextField({
    super.key,
    this.height = 54,
    this.controller,
    this.hintText,
    this.hintTextStyle,
    this.sufIcon,
    this.preIcon,
    this.onChange,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),  // Use the customizable borderRadius
        color: AppColors.greyLight,
      ),
      child: TextField(
        textInputAction: TextInputAction.done,
        onChanged: onChange,
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText ?? 'Enter text...',
          hintStyle: hintTextStyle ?? h6.copyWith(color: AppColors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: preIcon,
          suffixIcon: sufIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
