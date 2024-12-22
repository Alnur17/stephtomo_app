import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/bookmarks/views/bookmarks_view.dart';
import 'package:stephtomo_app/app/modules/home/views/home_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/profile_view.dart';
import 'package:stephtomo_app/app/modules/video/views/video_view.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import '../../../../common/app_color/app_colors.dart';
import 'widgets/bnb_custom_painter.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Screens managed as a list
    final List<Widget> screens = [
      HomeView(),
      VideoView(),
      BookmarksView(),
      ProfileView(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Display the selected screen based on the index
          Obx(() => IndexedStack(
                index: dashboardController.currentIndex.value,
                children: screens,
              )),
          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                  ),
                  Center(
                    heightFactor: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.mainColor, // Set the border color
                          width: 4.0, // Set the border width
                        ),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.bottomBackColor,
                        shape: const CircleBorder(),
                        elevation: 4.0,
                        onPressed: () {},
                        child: Image.asset(
                          AppImages.arrowRightUp,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildBottomNavItem(AppImages.homeFilled,
                            AppImages.homeOutline, "Home", 0),
                        buildBottomNavItem(AppImages.videoFilled,
                            AppImages.videoOutline, "Video", 1),
                        Container(width: size.width * 0.20), // Spacer for FAB
                        buildBottomNavItem(AppImages.bookmarkFilled,
                            AppImages.bookmarkOutline, "Bookmarks", 2),
                        buildBottomNavItem(AppImages.personFilled,
                            AppImages.personOutline, "Profile", 3),
                      ],
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

  // Helper method to build bottom navigation items
  Widget buildBottomNavItem(
      String activeImage, String inactiveImage, String label, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => dashboardController.setBottomBarIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              dashboardController.currentIndex.value == index
                  ? activeImage // Use filled image for active state
                  : inactiveImage, // Use outline image for inactive state
              //height: 24,
              scale: 4,
            ),
            const SizedBox(height: 4), // Spacing between image and label
            Text(
              label,
              style: TextStyle(
                color: dashboardController.currentIndex.value == index
                    ? AppColors.mainColor
                    : AppColors.bottomFadeColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
