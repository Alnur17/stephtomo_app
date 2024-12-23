import 'package:flutter/material.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';

import '../app_images/app_images.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.white,
      icon: Image.asset(
        AppImages.menuVer,
        scale: 4,
      ),
      onSelected: (value) {
        switch (value) {
          case 'copy_link':
            print('Copy link tapped');
            break;
          case 'edit':
            print('Edit tapped');
            break;
          case 'delete':
            print('Delete tapped');
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'copy_link',
          child: Row(
            children: [
              Icon(Icons.link, color: Colors.teal),
              SizedBox(width: 8),
              Text('Copy link'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}