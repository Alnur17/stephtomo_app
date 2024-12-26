import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../../../data/dummy_data.dart';
import '../controllers/write_email_controller.dart';

class WriteEmailView extends StatefulWidget {
  const WriteEmailView({super.key});

  @override
  State<WriteEmailView> createState() => _WriteEmailViewState();
}

class _WriteEmailViewState extends State<WriteEmailView> {
  final WriteEmailController controller = Get.put(WriteEmailController());
  String? selectedEmail;
  DateTime? reminderDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Write",
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
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('From:', style: h4),
                  sw8,
                  PopupMenuButton(
                    color: AppColors.white,
                    icon: Image.asset(
                      AppImages.arrowDown,
                      scale: 4,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Container(
                          width: 300,
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              CustomButton(
                                onPressed: () {
                                  controller.markAll();
                                },
                                text: 'Mark all',
                                borderRadius: 30,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final person = data[index];
                                    return Obx(
                                      () => ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(person['image']),
                                        ),
                                        title: Text(person['name']),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(person['role']),
                                            Text(person['university'],maxLines: 1, overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            controller.toggleCheckbox(index);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: ShapeDecoration(
                                              shape: CircleBorder(),
                                            ),
                                            child: Image.asset(
                                              controller.checkbox[index].value
                                                  ? AppImages.checkboxFilled
                                                  : AppImages.checkbox,
                                              scale: 4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text('Subject:', style: h4),
                  sw8,
                  Expanded(
                    child: CustomTextField(
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
                hintText: 'Compose email',
              ),
              sh16,
              Text(
                "Chose Video",
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
                onPressed: () {},
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
            "Name: Istiak",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Grad Year: 2006",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "GPA: 5.00",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Sports: Baseball",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Height: 5'6\"",
            style: h5.copyWith(
              color: AppColors.white,
            ),
          ),
          sh5,
          Text(
            "Primary Position: ",
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
      onTap: () {},
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
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: reminderDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            reminderDate = pickedDate;
          });
        }
      },
      child: Row(
        children: [
          Text(
            'Reminder Date',
            style: h3,
          ),
          Spacer(),
          Container(
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
                  reminderDate == null
                      ? "Select Reminder  "
                      : DateFormat("dd MMM  ").format(reminderDate!),
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
          ),
        ],
      ),
    );
  }
}
