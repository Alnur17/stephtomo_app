import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/home/controllers/home_controller.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/college_profile_card.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getBookmarkedColleges();
  }

  Future<void> _refreshData() async {
    await homeController.getBookmarkedColleges();
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
        if (homeController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.mainColor));
        }

        final savedSchoolIds = homeController.savedSchool;
        final allSchools = homeController.allSchool;
        final savedColleges = allSchools.where((school) => savedSchoolIds.contains(school.id)).toList();

        if (savedColleges.isEmpty) {
          return const Center(
            child: Text(
              'No saved colleges.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.builder(
            itemCount: savedColleges.length,
            itemBuilder: (context, index) {
              final college = savedColleges[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == savedColleges.length - 1 ? 100 : 8,
                  right: 16,
                  left: 16,
                ),
                child: CollegeProfileCard(
                  image: college.image ?? '',
                  university: college.name ?? 'Unknown',
                  name: college.coach?.name ?? 'Unknown',
                  role: college.coach?.position ?? '',
                  email: college.coach?.email ?? '',
                  isSaved: homeController.isSaved(college),
                  onFacebookTap: () {},
                  onTwitterTap: () {},
                  onInstagramTap: () {},
                  onBookmarkTap: () {
                    homeController.toggleSaveSchool(college);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
