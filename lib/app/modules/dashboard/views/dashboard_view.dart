import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/write_email/views/write_email_view.dart';
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
  void initState() {
    super.initState();
    // Get index from arguments, default to 0
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null && Get.arguments['index'] != null) {
        dashboardController.setBottomBarIndex(Get.arguments['index']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => IndexedStack(
              index: dashboardController.currentIndex.value,
              children: dashboardController.screens,
            ),
          ),
          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
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
                    heightFactor: 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 4.0,
                        ),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.bottomBackColor,
                        shape: const CircleBorder(),
                        elevation: 4.0,
                        onPressed: () {
                          Get.to(() => WriteEmailView());
                        },
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
                  ? activeImage
                  : inactiveImage,
              scale: 4,
            ),
            const SizedBox(height: 4),
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
