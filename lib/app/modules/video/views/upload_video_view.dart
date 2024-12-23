import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_text_style/styles.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/widgets/custom_textfelid.dart';

class UploadVideoView extends StatelessWidget {
  const UploadVideoView({super.key});

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
              "Upload video",
              style: h5,
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(AppImages.upload,scale: 4,),
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
          onPressed: () {},
        ),
      ),
    );
  }
}
