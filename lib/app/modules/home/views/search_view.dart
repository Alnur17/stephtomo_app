import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/widgets/search_filed.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../controllers/home_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final HomeController homeController = Get.find<HomeController>(); // Use Get.find() instead of Get.put()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Search',
          style: titleStyle,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Field
            SearchFiled(
              onChanged: (value) {
                homeController.searchColleges(value); // Use existing filtered data
              },
            ),
            sh16,

            // Search Results
            Expanded(
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.mainColor),
                  );
                } else if (homeController.filteredData.isEmpty) {
                  return Center(
                    child: Text(
                      'No colleges found.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: homeController.filteredData.length,
                    itemBuilder: (context, index) {
                      var college = homeController.filteredData[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CollegeProfileCard(
                          image: college.image ?? "Unknown",
                          university: college.collegeName ?? "",
                          name: college.coachName ?? "",
                          role: college.coachTitle ?? "",
                          email: college.coachEmail ?? "",
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
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
