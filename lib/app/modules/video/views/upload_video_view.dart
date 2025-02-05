import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/widgets/custom_loader.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_text_style/styles.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';
import 'package:stephtomo_app/common/widgets/custom_textfelid.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import '../controllers/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class UploadVideoView extends StatefulWidget {
  const UploadVideoView({super.key});

  @override
  State<UploadVideoView> createState() => _UploadVideoViewState();
}

class _UploadVideoViewState extends State<UploadVideoView> {
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Upload Video',
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
              controller: uploadVideoController.titleController,
              hintText: "Enter your title name",
            ),
            const SizedBox(height: 24),
            Text("Upload Video", style: h5),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: uploadVideoController.pickVideo,
              child: Obx(
                () => Container(
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: uploadVideoController.isVideoLoading.value
                        ? const CircularProgressIndicator()
                        : uploadVideoController.selectedVideo.value == null
                            ? Image.asset(AppImages.upload, scale: 4)
                            : uploadVideoController
                                            .videoPlayerController.value !=
                                        null &&
                                    uploadVideoController.videoPlayerController
                                        .value!.value.isInitialized
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      height: 250,
                                      child: VideoPlayer(uploadVideoController
                                          .videoPlayerController.value!),
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: Obx(() => uploadVideoController.isUploading.value
            ? CustomLoader(color: AppColors.white)
            : CustomButton(
                text: 'Submit',
                onPressed: uploadVideoController.uploadVideo,
              )),
      ),
    );
  }
}
