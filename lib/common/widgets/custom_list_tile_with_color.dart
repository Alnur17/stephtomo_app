import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomListTileWithColor extends StatelessWidget {
  final String leadingIconPath;
  final String title;
  final String? trailingIconPath; // Made optional
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CustomListTileWithColor({
    super.key,
    required this.leadingIconPath,
    required this.title,
    this.trailingIconPath, // Defaults to null
    required this.onTap,
    this.backgroundColor = AppColors.creamColorLight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                leadingIconPath,
                scale: 4,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: h3,
              ),
              const Spacer(),
              if (trailingIconPath != null)
                Image.asset(
                  trailingIconPath!,
                  scale: 4,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
