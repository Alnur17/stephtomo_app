import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';

class EmailView extends StatefulWidget {
  final String? image;
  final String name;
  final String time;
  final String title;
  final List<String> emails;
  final String message;

  const EmailView({
    super.key,
    required this.image,
    required this.title,
    required this.emails,
    required this.name,
    required this.time,
    required this.message,
  });

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Email',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.image ?? ''),
              ),
              title: Text(widget.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.emails[0], // Showing first email
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.emails.length >
                                1) // Showing arrow only if multiple emails
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
                      ),
                      Text(widget.time),
                    ],
                  ),
                  if (_isExpanded && widget.emails.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: widget.emails
                            .skip(1) // Skip first email as it's shown above
                            .map((email) => Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    email,
                                    textAlign: TextAlign.right,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                widget.title,
                style: titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.message),
            ),
          ],
        ),
      ),
    );
  }
}
