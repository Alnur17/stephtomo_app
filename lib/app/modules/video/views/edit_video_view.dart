import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/edit_video_controller.dart';

class EditVideoView extends GetView {
  final String videoId;
  final String videoTitle;
  final String videoUrl;

  EditVideoView(
      {super.key,
      required this.videoId,
      required this.videoTitle,
      required this.videoUrl});

  final EditVideoController editVideoController =
      Get.put(EditVideoController());

  @override
  Widget build(BuildContext context) {
    // Pre-fill the title when the screen loads
    editVideoController.titleController.text = videoTitle;

    // Initialize video if not already initialized
    editVideoController.initializeExistingVideo(videoUrl);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Edit Video',
          style: titleStyle,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title", style: h5),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Enter your title name",
              controller: editVideoController.titleController,
            ),
            const SizedBox(height: 24),
            Text("Update Video", style: h5),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: editVideoController.pickVideo,
              child: Obx(
                    () => Container(
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: editVideoController.selectedVideo.value == null
                        ? (editVideoController.videoPlayerController.value?.value.isInitialized ?? false
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover, // Ensures the video fits without black bars
                          child: SizedBox(
                            width: editVideoController.videoPlayerController.value!.value.size.width,
                            height: editVideoController.videoPlayerController.value!.value.size.height,
                            child: VideoPlayer(editVideoController.videoPlayerController.value!),
                          ),
                        ),
                      ),
                    )
                        : const CircularProgressIndicator())
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover, // Ensures the video takes the full space
                          child: SizedBox(
                            width: editVideoController.videoPlayerController.value!.value.size.width,
                            height: editVideoController.videoPlayerController.value!.value.size.height,
                            child: VideoPlayer(editVideoController.videoPlayerController.value!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: Obx(() => editVideoController.isUpdating.value
            ? CustomLoader(color: AppColors.white)
            : CustomButton(
          text: 'Save Changes',
          onPressed: () => editVideoController.updateVideo(videoId),
        )),
      ),
    );
  }

}
