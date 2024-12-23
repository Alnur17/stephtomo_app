import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/dummy_data.dart';
import 'package:stephtomo_app/common/widgets/custom_popup_menu_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class VideoDetailsView extends GetView {
  final String videoImage;
  final String videoTitle;

  const VideoDetailsView(
    this.videoImage,
    this.videoTitle, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Video Details',
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
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      videoImage,
                      fit: BoxFit.cover,
                      height: Get.height,
                      width: Get.width,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.black38,
                      ),
                      child: Image.asset(
                        AppImages.play,
                        scale: 4,
                      ),
                    ),
                  ),
                )
              ],
            ),
            sh16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Basics of UI/UX Design',
                  style: titleStyle,
                ),
                CustomPopupMenuButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
