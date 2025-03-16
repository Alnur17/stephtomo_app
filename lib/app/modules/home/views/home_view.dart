import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stephtomo_app/app/modules/home/views/notification_view.dart';
import 'package:stephtomo_app/app/modules/home/views/search_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/profile_view.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> _refreshData() async {
    await homeController.fetchSchoolData();
  }

  @override
  void initState() {
    super.initState();
    homeController.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildTopSection(context),
          sh30,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RefreshIndicator(
                color: AppColors.mainColor,
                backgroundColor: AppColors.white,
                onRefresh: _refreshData,
                child: Obx(() {
                  if (homeController.isLoading.value) {
                    return _buildShimmerList();
                  } else if (homeController.filteredData.isEmpty) {
                    return _buildNoDataView();
                  } else {
                    return _buildCollegeList();
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: 190,
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
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
              child: Obx(
                () => ListTile(
                  onTap: () {
                    Get.to(() => ProfileView(
                          showBackButton: true,
                        ));
                  },
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: profileController
                                .profileData.value?.profileImage !=
                            null
                        ? NetworkImage(
                            profileController.profileData.value!.profileImage!)
                        : AssetImage(AppImages.profileAvatarPlaceholder)
                            as ImageProvider,
                  ),
                  title: Text(
                    profileController.profileName.value.isNotEmpty
                        ? profileController.profileName.value
                        : 'User Name',
                    style: appBarStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  subtitle: Text(
                    profileController.profileData.value?.address?.isNotEmpty ==
                            true
                        ? profileController.profileData.value!.address!
                        : 'Address Placeholder',
                    style: h5.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Get.to(() => NotificationView());
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
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.white,
                    border: Border.all(color: AppColors.silver),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.search,
                        scale: 4,
                      ),
                      sw12,
                      Text(
                        'Search College',
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
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollegeList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sh16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Recommended College',
            style: h3.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        sh16,
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: homeController.filteredData.length,
            itemBuilder: (context, index) {
              var school = homeController.filteredData[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom:
                      index == homeController.filteredData.length - 1 ? 100 : 8,
                ),
                child: Obx(() {
                  return SchoolProfileCard(
                    image: school.image ?? '',
                    university: school.name ?? "",
                    name: school.coach?.name ?? "",
                    role: school.coach?.position ?? "",
                    email: school.coach?.email ?? "",
                    isSaved: homeController.isSaved(school),
                    onFacebookTap: () {
                      log('${school.facebookLink}');
                    },
                    onTwitterTap: () {
                      log('${school.xLink}');
                    },
                    onInstagramTap: () {
                      log('${school.instagramLink}');
                    },
                    onBookmarkTap: () {
                      homeController.toggleSaveSchool(school);
                    },
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoDataView() {
    return Center(
      child: Text(
        'No recommended colleges available.',
        style: h3.copyWith(color: AppColors.grey),
      ),
    );
  }
}
