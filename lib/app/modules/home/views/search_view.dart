import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/common/widgets/search_filed.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../../../data/dummy_data.dart';

class SearchView extends GetView {
  const SearchView({super.key});

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
              onChanged: (value) {},
            ),
            sh16,
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return CollegeProfileCard(
                    image: item['image'] ?? AppImages.collegeImage,
                    university: item['university'],
                    name: item['name'],
                    role: item['role'],
                    email: item['email'],
                    onFacebookTap: () {},
                    onTwitterTap: () {},
                    onInstagramTap: () {},
                    onBookmarkTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
