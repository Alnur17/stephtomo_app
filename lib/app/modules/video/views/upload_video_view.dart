import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_text_style/styles.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/widgets/custom_textfelid.dart';

class UploadVideoView extends StatefulWidget {
  const UploadVideoView({super.key});

  @override
  State<UploadVideoView> createState() => _UploadVideoViewState();
}

class _UploadVideoViewState extends State<UploadVideoView> {
  File? _selectedVideo;
  VideoPlayerController? _videoPlayerController;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
        _initializeVideoPlayer();
      });
    }
  }

  void _initializeVideoPlayer() {
    if (_selectedVideo != null) {
      _videoPlayerController = VideoPlayerController.file(_selectedVideo!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  void _clearVideo() {
    setState(() {
      _selectedVideo = null;
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
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
          'Upload Video',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: h5,
            ),
            SizedBox(height: 8),
            CustomTextField(
              hintText: "Enter your title name",
            ),
            SizedBox(height: 24),
            Text(
              "Upload Video",
              style: h5,
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: _selectedVideo == null
                      ? Image.asset(
                    AppImages.upload,
                    scale: 4,
                  )
                      : _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 250,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  )
                      : CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: CustomButton(
          text: 'Submit',
          onPressed: () {
            if (_selectedVideo != null) {
              Get.snackbar(
                'Success',
                'Video submitted successfully!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
              _clearVideo();
            } else {
              Get.snackbar(
                'Error',
                'Please select a video before submitting.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.red,
                colorText: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
