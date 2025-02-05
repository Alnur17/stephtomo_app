import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';

class EditVideoController extends GetxController {
  Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  final TextEditingController titleController = TextEditingController();
  RxBool isUpdating = false.obs;
  RxBool isVideoLoading = false.obs;

  void initializeExistingVideo(String videoUrl) {
    if (videoUrl.isNotEmpty) {
      videoPlayerController.value = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          videoPlayerController.value!.setLooping(true);
          videoPlayerController.refresh(); // This updates Obx()
        }).catchError((error) {
          print("Error initializing video: $error");
        });
    }
  }
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

  Future<void> updateVideo(String videoId) async {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a title.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUpdating.value = true;

    try {
      String token = LocalStorage.getData(key: AppConstant.token);
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(Api.updateVideo(id: videoId)),
      );

      Map<String, dynamic> payloadData = {
        "title": titleController.text.trim(), // Include title change
      };

      request.fields['payload'] = jsonEncode(payloadData);

      // **Attach video only if the user selected a new one**
      if (selectedVideo.value != null) {
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
      }

      request.headers['Authorization'] = 'Bearer, $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseData = jsonDecode(responseString);

      isUpdating.value = false;

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Video updated successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearVideo();
        titleController.clear();
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Update failed: ${responseData["message"] ?? "Unknown error"}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isUpdating.value = false;
      Get.snackbar(
        'Error',
        'Update failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    }
  }


  void clearVideo() {
    selectedVideo.value = null;
    videoPlayerController.value?.dispose();
    videoPlayerController.value = null;
  }

  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    titleController.dispose();
    super.onClose();
  }
}
