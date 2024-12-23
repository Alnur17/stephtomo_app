import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_text_style/styles.dart';

import '../../../../common/app_images/app_images.dart';

class UploadVideoView extends StatefulWidget {
  const UploadVideoView({super.key});

  @override
  State<UploadVideoView> createState() => _UploadVideoViewState();
}

class _UploadVideoViewState extends State<UploadVideoView> {
  File? _video;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadVideo(File video) async {
    final url = Uri.parse(""); //server URL needed
    final request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath(
      'video', // Field name in the API
      video.path,
      filename: basename(video.path),
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Video uploaded successfully!");
    } else {
      print("Video upload failed: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('Upload Video',style: titleStyle,),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _video != null
                ? Text("Selected video: ${basename(_video!.path)}")
                : Text("No video selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text("Pick Video"),
            ),
            ElevatedButton(
              onPressed: _video != null ? () => _uploadVideo(_video!) : null,
              child: Text("Upload Video"),
            ),
          ],
        ),
      ),
    );
  }
}
