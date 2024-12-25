import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/common/widgets/search_filed.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../../../data/dummy_data.dart';
import '../controllers/home_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final HomeController homeController = Get.put(HomeController());

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
            SearchFiled(
              onChanged: (value) {
                homeController.searchColleges(value, data);
              },
            ),
            sh16,
            Expanded(
              child: Obx(
                    () {
                  if (homeController.filteredData.isEmpty) {
                    return Center(
                      child: Text(
                        'Data not found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: homeController.filteredData.length,
                      itemBuilder: (context, index) {
                        var item = homeController.filteredData[index];
                        return Obx(
                              () => CollegeProfileCard(
                            image: item['image'],
                            university: item['university'],
                            name: item['name'],
                            role: item['role'],
                            email: item['email'],
                            isSaved: homeController.isSaved(item),
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
