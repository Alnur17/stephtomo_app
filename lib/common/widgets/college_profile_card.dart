import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class CollegeProfileCard extends StatelessWidget {
  final String image;
  final String university;
  final String name;
  final String role;
  final String email;
  final VoidCallback onFacebookTap;
  final VoidCallback onTwitterTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onBookmarkTap;
  final bool isSaved;

  const CollegeProfileCard({
    super.key,
    required this.image,
    required this.university,
    required this.name,
    required this.role,
    required this.email,
    required this.onFacebookTap,
    required this.onTwitterTap,
    required this.onInstagramTap,
    required this.onBookmarkTap,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AppImages.collegeImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    university,
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    name,
                    style: subTitleStyle,
                  ),
                  Text(
                    role,
                    style: h7.copyWith(color: AppColors.black100),
                  ),
                  Text(
                    email,
                    style: h7.copyWith(color: AppColors.black100),
                  ),
                  sh8,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onFacebookTap,
                        child: Image.asset(
                          AppImages.facebook,
                          scale: 4,
                        ),
                      ),
                      sw16,
                      GestureDetector(
                        onTap: onTwitterTap,
                        child: Image.asset(
                          AppImages.twitter,
                          scale: 4,
                        ),
                      ),
                      sw16,
                      GestureDetector(
                        onTap: onInstagramTap,
                        child: Image.asset(
                          AppImages.instagram,
                          scale: 4,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Image.asset(
                          isSaved ? AppImages.bookmarkFilled : AppImages.bookmarkAdd,
                          scale: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
