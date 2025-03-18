import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class SchoolProfileCard extends StatelessWidget {
  final String image;
  final String university;
  final String name;
  final String role;
  final String email;
  final String? facebookUrl;
  final String? twitterUrl;
  final String? instagramUrl;
  final String staffDirectory;
  final String idCamp;
  final VoidCallback onBookmarkTap;
  final bool isSaved;

  const SchoolProfileCard({
    super.key,
    required this.image,
    required this.university,
    required this.name,
    required this.role,
    required this.email,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    required this.staffDirectory,
    required this.idCamp,
    required this.onBookmarkTap,
    this.isSaved = false,
  });

  // Function to launch URLs
  Future<void> _launchUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  // Helper method to check if a URL is valid
  bool _isValidUrl(String? url) {
    return url != null && url.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _launchUrl(staffDirectory),
            child: Container(
              height: 170,
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AppImages.notFound,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _launchUrl(staffDirectory),
                    child: Text(
                      university,
                      style: titleStyle.copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  sh5,
                  Text(
                    name,
                    style: subTitleStyle,
                  ),
                  Text(
                    role,
                    style: h6.copyWith(color: AppColors.black100),
                  ),
                  Text(
                    email,
                    style: h6.copyWith(color: AppColors.black100),
                  ),
                  sh5,
                  GestureDetector(
                    onTap: () => _launchUrl(idCamp),
                    child: Text(
                      "ID Camp",
                      style: h5.copyWith(
                        color: AppColors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  sh12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_isValidUrl(facebookUrl))
                        GestureDetector(
                          onTap: () => _launchUrl(facebookUrl),
                          child: Container(
                            width: 35,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(color: AppColors.black100),
                              ),
                            ),
                            child: Image.asset(
                              AppImages.facebook,
                              scale: 4,
                            ),
                          ),
                        ),
                      sw5,
                      if (_isValidUrl(twitterUrl))
                        GestureDetector(
                          onTap: () => _launchUrl(twitterUrl),
                          child: Container(
                            width: 35,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(color: AppColors.black100),
                              ),
                            ),
                            child: Image.asset(
                              AppImages.twitter,
                              scale: 4,
                            ),
                          ),
                        ),
                      sw5,
                      if (_isValidUrl(instagramUrl))
                        GestureDetector(
                          onTap: () => _launchUrl(instagramUrl),
                          child: Container(
                            width: 35,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(color: AppColors.black100),
                              ),
                            ),
                            child: Image.asset(
                              AppImages.instagram,
                              scale: 4,
                            ),
                          ),
                        ),
                      Spacer(),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Container(
                          width: 35,
                          decoration: ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(color: AppColors.black100),
                            ),
                          ),
                          child: Image.asset(
                            isSaved
                                ? AppImages.bookmarkFilled
                                : AppImages.bookmarkAdd,
                            scale: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}