import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stephtomo_app/app/modules/home/controllers/home_controller.dart';
import 'package:stephtomo_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/write_email_controller.dart';

class WriteEmailView extends StatefulWidget {
  const WriteEmailView({super.key});

  @override
  State<WriteEmailView> createState() => _WriteEmailViewState();
}

class _WriteEmailViewState extends State<WriteEmailView> {
  final WriteEmailController writeEmailController =
      Get.put(WriteEmailController());
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  String? selectedEmail;
  DateTime? reminderDate;
  File? selectedVideo; // Video is nullable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Write Email",
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
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('To : ', style: h4),
                  sw8,
                  Expanded(
                    child: CustomTextField(
                      controller: writeEmailController.emailController,
                    ),
                  )
                  // PopupMenuButton(
                  //   color: AppColors.white,
                  //   icon: Image.asset(
                  //     AppImages.arrowDown,
                  //     scale: 4,
                  //   ),
                  //   itemBuilder: (context) => [
                  //     PopupMenuItem(
                  //       child: Container(
                  //         width: 300,
                  //         height: 400,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(24),
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             CustomButton(
                  //               onPressed: () {
                  //                 writeEmailController.markAll();
                  //               },
                  //               text: 'Mark all',
                  //               borderRadius: 30,
                  //             ),
                  //             Expanded(
                  //               child: ListView.builder(
                  //                 itemCount: homeController.allSchool.length,
                  //                 itemBuilder: (context, index) {
                  //                   final coachData =
                  //                   homeController.allSchool[index];
                  //                   return Obx(
                  //                         () => ListTile(
                  //                       leading: CircleAvatar(
                  //                         backgroundImage: NetworkImage(
                  //                             coachData.coach?.image ?? ""),
                  //                       ),
                  //                       title:
                  //                       Text(coachData.coach?.name ?? ""),
                  //                       subtitle: Column(
                  //                         crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(coachData.coach?.position ?? ""),
                  //                           Text(
                  //                             coachData.name ?? "",
                  //                             maxLines: 1,
                  //                             overflow: TextOverflow.ellipsis,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       trailing: GestureDetector(
                  //                         onTap: () {
                  //                           writeEmailController.toggleCheckbox(index);
                  //                         },
                  //                         child: Container(
                  //                           height: 50,
                  //                           decoration: ShapeDecoration(
                  //                             shape: CircleBorder(),
                  //                           ),
                  //                           child: Image.asset(
                  //                             writeEmailController.checkbox[index].value
                  //                                 ? AppImages.checkboxFilled
                  //                                 : AppImages.checkbox,
                  //                             scale: 4,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text('Subject : ', style: h4),
                  sw8,
                  Expanded(
                    child: CustomTextField(
                      controller: writeEmailController.subjectController,
                      containerColor: AppColors.transparent,
                    ),
                  ),
                ],
              ),
              Divider(),
              sh16,
              _buildProfileSummary(),
              sh16,
              CustomTextField(
                height: 150,
                controller: writeEmailController.messageController,
                hintText: 'Compose email',
              ),
              sh16,
              Text(
                "Choose Video",
                style: h4,
              ),
              sh8,
              _buildUploadContainer(),
              sh16,
              _buildReminderDatePicker(),
              sh24,
              CustomButton(
                imageAssetPath: AppImages.send,
                text: 'Send',
                onPressed: () async {
                  String? reminderDateString = reminderDate != null
                      ? DateFormat("yyyy-MM-dd").format(reminderDate!)
                      : null;

                  // Validate fields before sending the email
                  bool isValid =
                      writeEmailController.validateFields(selectedVideo);

                  if (isValid) {
                    writeEmailController.sendEmail(
                      [
                        writeEmailController.emailController.text
                      ], // Recipient Email
                      writeEmailController.subjectController.text,
                      writeEmailController.messageController.text,
                      reminderDateString,
                      selectedVideo,
                    );
                  }
                },
              ),
              sh16
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name: ${profileController.profileData.value?.name}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Grad Year: ${profileController.profileData.value?.gradYear}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "GPA: ${profileController.profileData.value?.gpa}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Sports: ${profileController.profileData.value?.sport}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Height: ${profileController.profileData.value?.height}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Primary Position: ${profileController.profileData.value?.primaryPosition}",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadContainer() {
    return GestureDetector(
      onTap: () async {
        // Trigger the video picker here to get the selected video file
        selectedVideo = await writeEmailController.pickVideo();
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            AppImages.upload,
            scale: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildReminderDatePicker() {
    return GestureDetector(
      onTap: () async {
        await writeEmailController.pickReminderDate(context);
      },
      child: Row(
        children: [
          Text(
            'Reminder Date',
            style: h3,
          ),
          Spacer(),
          Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      writeEmailController.reminderDate.value == null
                          ? "Select Reminder"
                          : DateFormat("dd MMM")
                              .format(writeEmailController.reminderDate.value!),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Image.asset(
                      AppImages.arrowDownGreen,
                      scale: 4,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
