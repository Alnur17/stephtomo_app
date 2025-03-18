// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../controllers/all_email_controller.dart';
// import 'email_view.dart';
//
// class AllEmailHistoryView extends StatelessWidget {
//   const AllEmailHistoryView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final AllEmailController emailController = Get.put(AllEmailController());
//
//     // Load sent emails when the widget is initialized
//     emailController.fetchSentEmails();
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         scrolledUnderElevation: 0,
//         title: Text('All Email History', style: titleStyle),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: Image.asset(AppImages.back, scale: 4),
//         ),
//       ),
//       body: Obx(() => _buildEmailList(
//           emailController.sentEmailData, emailController.isLoadingSent)),
//     );
//   }
//
//   Widget _buildEmailList(RxList<dynamic> emailData, RxBool isLoading) {
//     if (isLoading.value) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (emailData.isEmpty) {
//       return const Center(child: Text("No emails found"));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView.builder(
//         itemCount: emailData.length,
//         itemBuilder: (context, index) {
//           final data = emailData[index];
//
//           // Safe handling of data fields
//           final profileImage = data.from?.profileImage;
//           final title = data.subject ?? "No Subject";
//           final name = (data.from?.name ?? "Unknown");
//           final email = data.to.isNotEmpty ? data.to : "Unknown";
//           final emailBody = data.body ?? "No Content";
//           final timeAgo = _getTimeDifference(data.createdAt);
//
//           return GestureDetector(
//             onTap: () {
//               Get.to(() => EmailView(
//                     name: name,
//                     time: timeAgo,
//                     message: emailBody,
//                     image: profileImage ?? AppImages.profile,
//                     title: title,
//                     emails: email,
//                   ));
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 sh12,
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: profileImage != null
//                           ? NetworkImage(profileImage)
//                           : AssetImage(AppImages.profile) as ImageProvider,
//                     ),
//                     sw16,
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(name, style: h4),
//                           sh8,
//                           Text("To: ${email.join(', ')}", style: h6),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(timeAgo, style: h6),
//                         sh8,
//                         GestureDetector(
//                           onTap: () {
//                             // Dynamic content to share
//                             final shareContent = '''To: ${email.join(', ')} \nSubject: $title \nBody: $emailBody'''; // Customize this as needed
//                             Share.share(
//                               shareContent.trim(),
//                               subject:
//                                   title, // Optional subject for platforms that support it
//                             );
//                           },
//                           child: Image.asset(AppImages.share, scale: 4),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 sh8,
//                 Text(emailBody,
//                     style: h6, maxLines: 3, overflow: TextOverflow.ellipsis),
//                 sh8,
//                 const Divider(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Calculate the time difference for emails
//   String _getTimeDifference(DateTime? createdAt) {
//     return createdAt != null
//         ? "${timeago.format(createdAt, locale: 'en_short')} ago"
//         : 'Unknown time';
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
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

    // Load sent emails when the widget is initialized
    emailController.fetchSentEmails();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('All Email History', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Obx(() => _buildEmailList(
          emailController.sentEmailData, emailController.isLoadingSent)),
    );
  }

  Widget _buildEmailList(RxList<dynamic> emailData, RxBool isLoading) {
    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (emailData.isEmpty) {
      return const Center(child: Text("No emails found"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: emailData.length,
        itemBuilder: (context, index) {
          final data = emailData[index];
          return EmailListItem(data: data);
        },
      ),
    );
  }
}

// New StatefulWidget for each email item to handle dropdown
class EmailListItem extends StatefulWidget {
  final dynamic data;

  const EmailListItem({super.key, required this.data});

  @override
  State<EmailListItem> createState() => _EmailListItemState();
}

class _EmailListItemState extends State<EmailListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Safe handling of data fields
    final profileImage = widget.data.from?.profileImage;
    final title = widget.data.subject ?? "No Subject";
    final name = widget.data.from?.name ?? "Unknown";
    final emails = widget.data.to.isNotEmpty ? widget.data.to : ["Unknown"];
    final emailBody = widget.data.body ?? "No Content";
    final timeAgo = _getTimeDifference(widget.data.createdAt);

    return GestureDetector(
      onTap: () {
        Get.to(() => EmailView(
          name: name,
          time: timeAgo,
          message: emailBody,
          image: profileImage ?? AppImages.profile,
          title: title,
          emails: emails,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: profileImage != null
                    ? NetworkImage(profileImage)
                    : AssetImage(AppImages.profile) as ImageProvider,
              ),
              sw16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: h4),
                    sh8,
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "To: ${emails[0]}",
                            style: h6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (emails.length > 1)
                          IconButton(
                            icon: Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                          ),
                      ],
                    ),
                    if (_isExpanded && emails.length > 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: emails.skip(1).map<Widget>((email) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(email, style: h6),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(timeAgo, style: h6),
                  sh8,
                  GestureDetector(
                    onTap: () {
                      final shareContent =
                      '''To: ${emails.join(', ')} \nSubject: $title \nBody: $emailBody''';
                      Share.share(
                        shareContent.trim(),
                        subject: title,
                      );
                    },
                    child: Image.asset(AppImages.share, scale: 4),
                  ),
                ],
              ),
            ],
          ),
          sh8,
          Text(
            emailBody,
            style: h6,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          sh8,
          const Divider(),
        ],
      ),
    );
  }

  String _getTimeDifference(DateTime? createdAt) {
    return createdAt != null
        ? "${timeago.format(createdAt, locale: 'en_short')} ago"
        : 'Unknown time';
  }
}

// void _showSharePopup() {
//   Get.bottomSheet(
//     Container(
//       height: 350,
//       padding:
//           const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 30),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildShareOption(AppImages.instagramShare, 'Instagram'),
//               _buildShareOption(AppImages.twitterShare, 'X'),
//               _buildShareOption(AppImages.facebookShare, 'Facebook'),
//               _buildShareOption(AppImages.more, 'More'),
//             ],
//           ),
//           sh16,
//           const Divider(),
//           sh16,
//           Padding(
//             padding: const EdgeInsets.only(left: 16),
//             child: _buildShareOption(AppImages.copy, 'Copy link'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// final String shareLink = 'https://example.com/share_link';
//
// Widget _buildShareOption(String image, String label) {
//   return GestureDetector(
//     onTap: () => Share.share(
//       'Check out this post: $shareLink',
//       subject: 'Post Link',
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(image, scale: 4),
//         sh16,
//         Text(label, style: h6),
//       ],
//     ),
//   );
// }
