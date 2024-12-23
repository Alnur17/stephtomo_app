import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_text_style/styles.dart';

class WriteEmailView extends StatefulWidget {
  const WriteEmailView({super.key});

  @override
  _WriteEmailViewState createState() => _WriteEmailViewState();
}

class _WriteEmailViewState extends State<WriteEmailView> {
  String? selectedEmail;
  DateTime? reminderDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Email"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "From",
                  border: OutlineInputBorder(),
                ),
                value: selectedEmail,
                items: [
                  DropdownMenuItem(
                      value: "example1@gmail.com",
                      child: Text("example1@gmail.com")),
                  DropdownMenuItem(
                      value: "example2@gmail.com",
                      child: Text("example2@gmail.com")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedEmail = value;
                  });
                },
              ),
              SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  labelText: "Subject",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Compose Email Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: Istiak",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Grad Year: 2006",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("GPA: 5.00",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Sports: Baseball",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Height: 5'6\"",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Primary Position: ",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Club Team: ",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Club Coach: ",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Club Coach Number: ",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                    Text("Club Coach Email:",
                        style:
                            h5.copyWith(fontSize: 12, color: AppColors.white)),
                  ],
                ),
              ),
              SizedBox(height: 16),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                        Text("Upload Video"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Reminder Date Picker
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      reminderDate = pickedDate;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        reminderDate == null
                            ? "Select Reminder Date"
                            : DateFormat.yMMMMd().format(reminderDate!),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Send Button
              CustomButton(
                text: 'Send',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
