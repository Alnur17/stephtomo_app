import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';
import '../../app/modules/video/views/edit_video_view.dart';
import '../app_images/app_images.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final VoidCallback onDeleteSuccess;
  final String videoId;
  final String videoTitle;
  final String videoUrl;

  const CustomPopupMenuButton({
    super.key,
    required this.onDeleteSuccess,
    required this.videoId,
    required this.videoTitle,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.white,
      icon: Image.asset(AppImages.menuVer, scale: 4),
      onSelected: (value) {
        if (value == 'delete') {
          Get.defaultDialog(
            title: "Confirm Delete",
            middleText: "Are you sure you want to delete this video?",
            textConfirm: "Yes",
            textCancel: "No",
            confirmTextColor: Colors.white,
            onConfirm: () {
              onDeleteSuccess();
              Get.back();
            },
          );
        } else if (value == 'edit') {
          print("Editing video with ID: $videoId, URL: $videoUrl");
          Get.to(() => EditVideoView(

            videoId: videoId,
            videoTitle: videoTitle,
            videoUrl: videoUrl,
          ));
        } else {}
      },
      itemBuilder: (context) => [
        _buildMenuItem('Copy link', AppImages.copyLink, 'copy_link'),
        _buildMenuItem('Edit', AppImages.editTwo, 'edit'),
        _buildMenuItem('Delete', AppImages.delete, 'delete'),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      String text, String asset, String value) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Image.asset(asset, scale: 4),
          sw8,
          Text(text),
        ],
      ),
    );
  }
}
