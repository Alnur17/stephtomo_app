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
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getBookmarkedColleges();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('Saved Colleges', style: titleStyle),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final savedColleges = homeController.savedColleges;
        print(
            "Rendering bookmarks: ${savedColleges.length} items"); // Debugging

        if (savedColleges.isEmpty) {
          return const Center(
            child: Text(
              'No saved colleges.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: savedColleges.length,
          itemBuilder: (context, index) {
            final college = savedColleges[index];
            print("Displaying college: ${college.collegeName}"); // Debugging

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == savedColleges.length - 1 ? 100 : 8,
                right: 16,
                left: 16,
              ),
              child: CollegeProfileCard(
                image: college.image ?? '',
                university: college.collegeName ?? 'Unknown',
                name: college.coachName ?? 'Unknown',
                role: college.coachTitle ?? '',
                email: college.coachEmail ?? '',
                isSaved: homeController.isSaved(college),
                onFacebookTap: () {},
                onTwitterTap: () {},
                onInstagramTap: () {},
                onBookmarkTap: () {
                  homeController.toggleSaveCollege(college);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
