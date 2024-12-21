import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';

class CustomRectangleButton extends StatelessWidget {
  final Color? background;
  final Color? iconColor;
  final Widget? icon;
  final VoidCallback? onTap;

  const CustomRectangleButton({
    super.key,
    this.background = AppColors.grey,
    this.iconColor = AppColors.black,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: background,
        ),
        child: icon ?? Icon(Icons.add, color: iconColor),
      ),
    );
  }
}
