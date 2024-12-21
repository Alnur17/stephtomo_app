import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String placeholderImage;
  final VoidCallback onTap;
  final Rx<File?> profileImage;

  const ProfileAvatar({
    super.key,
    required this.radius,
    required this.placeholderImage,
    required this.onTap,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: profileImage.value != null
                ? FileImage(profileImage.value!)
                : AssetImage(placeholderImage) as ImageProvider,
          ),
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: radius * 0.35,
              backgroundColor: AppColors.grey,
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: radius * 0.35,
              ),
            ),
          ),
        ],
      );
    });
  }
}
