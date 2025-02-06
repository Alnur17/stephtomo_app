import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/all_email_controller.dart';
import 'email_view.dart';

class AllEmailHistoryView extends StatelessWidget {
  const AllEmailHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final AllEmailController emailController = Get.put(AllEmailController());

    // Load emails dynamically
    emailController.loadEmails();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('All Email History', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Obx(() {
        if (emailController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (emailController.emailData.isEmpty) {
          return Center(child: Text("No emails found"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: emailController.emailData.length,
            itemBuilder: (context, index) {
              final data = emailController.emailData[index];

              // Format the email creation time
              String formattedTime = _getTimeDifference(data.createdAt);

              return GestureDetector(
                onTap: () {
                  Get.to(() => EmailView(
                        name: data.signature!.name!,
                        time: formattedTime,
                        message: data.body!,
                        image: AppImages.profile,
                      ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sh12,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder image since there's no image URL in the model
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              AppImages.profile), // Use default avatar
                        ),
                        sw16,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.signature!.name!, style: h4),
                            sh8,
                            Text("From: ${data.from}", style: h6),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: Text(formattedTime, style: h6)),
                              sw8,
                              GestureDetector(
                                onTap: () {
                                  _showSharePopup();
                                },
                                child: Image.asset(AppImages.share, scale: 4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sh8,
                    Text(data.body!,
                        style: h6,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    sh8,
                    Divider(),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  // Method to calculate the time difference
  String _getTimeDifference(DateTime? createdAt) {
    if (createdAt == null) {
      return 'Unknown time';
    }

    String timeAgo = timeago.format(createdAt, locale: 'en_short');

    return "$timeAgo ago";
  }

  void _showSharePopup() {
    Get.bottomSheet(
      Container(
        height: 350,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(
                  image: AppImages.instagramShare,
                  label: 'Instagram',
                  onTap: () {},
                ),
                _buildShareOption(
                  image: AppImages.twitterShare,
                  label: 'X',
                  onTap: () {},
                ),
                _buildShareOption(
                  image: AppImages.facebookShare,
                  label: 'Facebook',
                  onTap: () {},
                ),
                _buildShareOption(
                  image: AppImages.more,
                  label: 'More',
                  onTap: () {},
                ),
              ],
            ),
            sh16,
            Divider(),
            sh16,
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildShareOption(
                image: AppImages.copy,
                label: 'Copy link',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required String image,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back(); // Close the bottom sheet
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image, scale: 4),
          sh16,
          Text(label, style: h6),
        ],
      ),
    );
  }
}
