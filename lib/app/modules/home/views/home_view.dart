import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/home/views/notification_view.dart';
import 'package:stephtomo_app/app/modules/home/views/search_view.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../../../data/dummy_data.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 175,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 16,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          AppImages.profile,
                        ),
                      ),
                      title: Text(
                        'Sultan Md. Alnur',
                        style: appBarStyle.copyWith(
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '47 W 13th St, NY, NY 10011, USA',
                        style: h5.copyWith(
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: GestureDetector(
                        onTap: (){
                          Get.to(()=> NotificationView());
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: Image.asset(
                            AppImages.notification,
                            scale: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: -25,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => SearchView());
                      },
                      child: Container(
                        height: 54,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white,
                            border: Border.all(color: AppColors.silver)),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.search,
                              scale: 4,
                            ),
                            sw12,
                            Text(
                              'Search Collage',
                              style: h5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sh50,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommend Collage',
                    style: h3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return Obx(() => CollegeProfileCard(
                          image: item['image'] ?? AppImages.collegeImage,
                          university: item['university'],
                          name: item['name'],
                          role: item['role'],
                          email: item['email'],
                          isSaved: controller.isSaved(item),
                          onFacebookTap: () {},
                          onTwitterTap: () {},
                          onInstagramTap: () {},
                          onBookmarkTap: () {
                            controller.toggleSaveCollege(item);
                          },
                        ));
                      },
                    ),
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
