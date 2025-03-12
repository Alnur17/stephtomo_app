import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? isTextStyleSelected;
  final double? height;
  final double? width;
  final String? imageAssetPath;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.isTextStyleSelected,
    this.height = 54,
    this.borderColor,
    this.imageAssetPath,
    this.borderRadius = 12,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: backgroundColor ?? AppColors.mainColor,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageAssetPath != null) ...[
                // Check if the image asset path is provided
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    imageAssetPath!,
                    scale: 4,
                  ),
                ),
              ],
              Text(
                text,
                style: h3.copyWith(
                  color: isTextStyleSelected != null
                      ? AppColors.mainColor
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
