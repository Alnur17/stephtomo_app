import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/app/modules/video/views/video_view.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/app/modules/video/controllers/video_controller.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:convert';

class UploadVideoController extends GetxController {
  final VideoController videoController = Get.find();

  Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<VideoPlayerController?> videoPlayerController =
  Rx<VideoPlayerController?>(null);
  final TextEditingController titleController = TextEditingController();
  RxBool isUploading = false.obs;
  RxBool isVideoLoading = false.obs;



  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      isVideoLoading.value = true;
      selectedVideo.value = File(pickedFile.path);
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() async {
    if (selectedVideo.value != null) {
      videoPlayerController.value =
      VideoPlayerController.file(selectedVideo.value!)
        ..initialize().then((_) {
          isVideoLoading.value = false;
          update();
        });
    }
  }

  void clearVideo() {
    selectedVideo.value = null;
    videoPlayerController.value?.dispose();
    videoPlayerController.value = null;
  }

  Future<void> uploadVideo() async {
    if (selectedVideo.value == null || titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a video and enter a title.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUploading.value = true;

    try {
      String token = LocalStorage.getData(key: AppConstant.token);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Api.uploadVideo),
      );

      // Encode payload as JSON
      Map<String, dynamic> payloadData = {
        "title": titleController.text.trim(),
      };

      request.fields['payload'] = jsonEncode(payloadData);

      // Attach Video File
      var videoStream = http.ByteStream(selectedVideo.value!.openRead());
      var videoLength = await selectedVideo.value!.length();
      var multipartFile = http.MultipartFile(
        'video',
        videoStream,
        videoLength,
        filename: basename(selectedVideo.value!.path),
        contentType: MediaType('video', 'mp4'),
      );
      request.files.add(multipartFile);

      request.headers['Authorization'] = 'Bearer, $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Send Request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseData = jsonDecode(responseString);

      isUploading.value = false;

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Video uploaded successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        videoController.fetchVideos();
        clearVideo();
        titleController.clear();
        Get.offAll(VideoView());
      } else {
        Get.snackbar(
          'Error',
          'Upload failed: ${responseData["message"] ?? "Unknown error"}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isUploading.value = false;
      Get.snackbar(
        'Error',
        'Upload failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    }
  }


  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    titleController.dispose();
    super.onClose();
  }
}
