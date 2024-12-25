import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/dummy_data.dart';
import 'package:stephtomo_app/app/modules/video/views/upload_video_view.dart';
import 'package:stephtomo_app/app/modules/video/views/video_details_view.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_popup_menu_button.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Video',
          style: titleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomButton(
              text: 'Add New Video',
              onPressed: () {
                Get.to(() => UploadVideoView());
              },
              imageAssetPath: AppImages.addCircle,
              borderRadius: 30,
            ),
            sh16,
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: videoData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  var videoItem = videoData[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          videoItem['image'],
                          fit: BoxFit.cover,
                          height: Get.height,
                          width: Get.width,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 0,
                        child: CustomPopupMenuButton(),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        left: 12,
                        child: Text(
                          videoItem['title'],
                          style: h4.copyWith(color: AppColors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => VideoDetailsView(
                              videoTitle: videoItem['title'],
                              videoUrl: videoItem['video'],
                                ));
                          },
                          child: Image.asset(
                            AppImages.play,
                            scale: 4,
                          ),
                        ),
                      ),
                    ],
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
