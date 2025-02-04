import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stephtomo_app/app/data/api.dart';
import 'package:stephtomo_app/common/widgets/custom_loader.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:convert';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../../../../common/app_images/app_images.dart';
import '../controllers/video_controller.dart';

class UploadVideoView extends StatefulWidget {
  const UploadVideoView({super.key});

  @override
  State<UploadVideoView> createState() => _UploadVideoViewState();
}

class _UploadVideoViewState extends State<UploadVideoView> {
  final VideoController videoController = Get.find();

  File? _selectedVideo;
  VideoPlayerController? _videoPlayerController;
  final TextEditingController _titleController = TextEditingController();
  bool _isUploading = false;

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

  Future<void> _uploadVideo() async {
    if (_selectedVideo == null || _titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a video and enter a title.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
      return ;
    }

    setState(() {
      _isUploading = true; // Start the loading process
    });

    try {
      String token = LocalStorage.getData(key: AppConstant.token);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Api.uploadVideo),
      );

      // ✅ Encode payload as JSON
      Map<String, dynamic> payloadData = {
        "title": _titleController.text.trim(),
      };

      request.fields['payload'] = jsonEncode(payloadData);

      // ✅ Attach Video File
      var videoStream = http.ByteStream(_selectedVideo!.openRead());
      var videoLength = await _selectedVideo!.length();
      var multipartFile = http.MultipartFile(
        'video',
        videoStream,
        videoLength,
        filename: basename(_selectedVideo!.path),
        contentType: MediaType('video', 'mp4'),
      );
      request.files.add(multipartFile);

      request.headers['Authorization'] = 'Bearer, $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // ✅ Send Request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var responseData = jsonDecode(responseString);

      setState(() {
        _isUploading = false; // End the loading process
      });

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Video uploaded successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        videoController.fetchVideos();
        _clearVideo();
        _titleController.clear();
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
      setState(() {
        _isUploading = false; // End the loading process
      });
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
  void dispose() {
    _videoPlayerController?.dispose();
    _titleController.dispose();
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
            Text("Title", style: h5),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _titleController,
              hintText: "Enter your title name",
            ),
            const SizedBox(height: 24),
            Text("Upload Video", style: h5),
            const SizedBox(height: 8),
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
                      ? Image.asset(AppImages.upload, scale: 4)
                      : _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 250,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  )
                      : const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: _isUploading== true ? CustomLoader(color: AppColors.white) : CustomButton(
          text: 'Submit',
          onPressed: _uploadVideo,

        )
      ),
    );
  }
}
