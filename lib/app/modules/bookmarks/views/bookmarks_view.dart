import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../../home/controllers/home_controller.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('Saved Collage', style: titleStyle),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final savedColleges = homeController.savedColleges();
        if (savedColleges.isEmpty) {
          return const Center(
            child: Text(
              'No saved colleges.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          itemCount: savedColleges.length,
          itemBuilder: (context, index) {
            final item = savedColleges[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == savedColleges.length - 1 ? 100 : 8,
              ),
              child: CollegeProfileCard(
                image: item['image'] ?? '',
                university: item['university'],
                name: item['name'],
                role: item['role'],
                email: item['email'],
                isSaved: true,
                onFacebookTap: () {},
                onTwitterTap: () {},
                onInstagramTap: () {},
                onBookmarkTap: () {
                  homeController.toggleSaveCollege(item);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
