import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../data/dummy_data.dart';

class AllEmailHistoryView extends StatelessWidget {
  const AllEmailHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'All Email History',
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
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: emailData.length,
          itemBuilder: (context, index) {
            final email = emailData[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(email['imageUrl']),
                    ),
                    sw16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email['name'], style: h4),
                        Text(email['role'], style: h4),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(email['time'], style: h4),
                        sw8,
                        Image.asset(
                          AppImages.eyeClose,
                          scale: 4,
                        ),
                      ],
                    ),
                  ],
                ),
                sh8,
                Text(
                  email['message'],
                  style: h6,
                ),
                sh8,
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}

