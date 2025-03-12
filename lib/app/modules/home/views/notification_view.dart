import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/home/controllers/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController notificationController =
  Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(
            'Notification',
            style: titleStyle,
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(AppImages.back, scale: 4)),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: notificationController.notificationList.length,
                  itemBuilder: (context, index) {
                    var notification = notificationController.notificationList[index];

                    // Convert the time to a readable format
                    // String time = notification.time != null
                    //     ? "${notification.time!.hour}:${notification.time!.minute}" // Format as needed
                    //     : "Unknown time";
                    //

                    String time = _getTimeDifference(notification.createdAt);

                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              color: AppColors.silver,
                            ),
                            child: Image.asset(
                              AppImages.notification,
                              scale: 4,
                            ),
                          ),
                          sw12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title ?? 'No Title',
                                  style: h6,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                sh5,
                                Text(
                                  notification.body ?? '',
                                  style: h7.copyWith(
                                    color: AppColors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          sw12,
                          Text(
                            time,
                            style: h7.copyWith(
                              color: AppColors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate the time difference for emails
  String _getTimeDifference(DateTime? createdAt) {
    return createdAt != null
        ? "${timeago.format(createdAt, locale: 'en_short')} ago"
        : 'Unknown time';
  }

}






// sw12,
// Container(
//   height: 25,
//   width: 25,
//   alignment: Alignment.center,
//   decoration: ShapeDecoration(
//     shape: CircleBorder(),
//     color: AppColors.mainColor,
//   ),
//   child: Text(
//     '2',
//     style: TextStyle(color: AppColors.white),
//   ),
// )