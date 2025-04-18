import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/video/controllers/upload_video_controller.dart';
import 'package:stephtomo_app/app/modules/video/views/upload_video_view.dart';
import 'package:stephtomo_app/app/modules/video/views/video_details_view.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_popup_menu_button.dart';
import '../controllers/video_controller.dart';

class VideoView extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  VideoView({super.key});

  /// Refresh video list
  Future<void> _refreshData() async {
    await videoController.fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Videos',
          style: titleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.white,
        color: AppColors.mainColor,
        onRefresh: _refreshData,
        child: Padding(
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
                child: Obx(() {
                  if (videoController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (videoController.videos.isEmpty) {
                    return Center(child: Text("No videos available"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: videoController.videos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      var videoItem = videoController.videos[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FutureBuilder<dynamic>(
                              future: videoController.generateThumbnail(videoItem.url ?? ''),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError || snapshot.data == null) {
                                  return Image.asset(
                                    AppImages.notFound,
                                    fit: BoxFit.cover,
                                    height: Get.height,
                                    width: Get.width,
                                  );
                                } else {
                                  return Image.file(
                                    File(snapshot.data!),
                                    fit: BoxFit.cover,
                                    height: Get.height,
                                    width: Get.width,
                                  );
                                }
                              },
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
                            child: CustomPopupMenuButton(
                              onDeleteSuccess: () {
                                videoController.deleteVideo(
                                  videoItem.id ?? '',
                                  videoItem.title ?? '',
                                  videoItem.url ?? '',
                                );
                              },
                              videoId: videoItem.id ?? '',
                              videoTitle: videoItem.title ?? '',
                              videoUrl: videoItem.url ?? '',
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            right: 12,
                            left: 12,
                            child: Text(
                              videoItem.title ?? '',
                              style: h4.copyWith(color: AppColors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => VideoDetailsView(
                                      videoTitle: videoItem.title ?? '',
                                      videoUrl: videoItem.url ?? '',
                                      id: videoItem.id ?? '',
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
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
