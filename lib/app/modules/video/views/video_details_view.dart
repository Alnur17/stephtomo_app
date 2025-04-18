import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/video/controllers/edit_video_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_popup_menu_button.dart';
import '../controllers/upload_video_controller.dart';
import '../controllers/video_controller.dart';

class VideoDetailsView extends StatefulWidget {
  final String videoTitle;
  final String videoUrl;
  final String id;

  const VideoDetailsView({
    required this.videoTitle,
    required this.videoUrl,
    required this.id,
    super.key,
  });

  @override
  State<VideoDetailsView> createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {
  final VideoController controller = Get.put(VideoController());
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  final EditVideoController editVideoController = Get.put(EditVideoController());

  @override
  void initState() {
    super.initState();
    controller.fetchVideos();
    // Ensure video is properly initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isInitialized.value ||
          controller.videoPlayerController == null) {
        controller.initializeVideo(widget.videoUrl);
      }
    });
  }

  @override
  void dispose() {
    // Dispose video player properly when leaving the screen
    controller.videoPlayerController?.pause();
    controller.videoPlayerController?.dispose();
    controller.videoPlayerController = null;
    controller.isInitialized.value = false;

    super.dispose();
  }

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
            controller.videoPlayerController?.pause();
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
                Obx(() {
                  if (controller.isInitialized.value &&
                      controller.videoPlayerController != null) {
                    return SizedBox(
                      height: 230,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: controller
                              .videoPlayerController!.value.aspectRatio,
                          child: GestureDetector(
                            onTap: controller.toggleControls,
                            child:
                                VideoPlayer(controller.videoPlayerController!),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.grey,
                      ),
                      height: 230,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
                Obx(() {
                  if (controller.showControls.value &&
                      controller.isInitialized.value) {
                    return Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: controller.togglePlayPause,
                          child: Icon(
                            controller.isPlaying.value
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
            sh16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:Text(
                    widget.videoTitle,
                    style: titleStyle,
                  ),
                ),
                CustomPopupMenuButton(
                  onDeleteSuccess: () {
                    controller.deleteVideo(
                      widget.id,
                      widget.videoTitle,
                      widget.videoUrl,
                    );
                  },
                  videoId: widget.id,
                  videoTitle: widget.videoTitle,
                  videoUrl: widget.videoUrl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
