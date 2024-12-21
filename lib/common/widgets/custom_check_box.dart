import 'package:flutter/material.dart';

import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class CustomCheckBox extends StatelessWidget {
  final String text;
  final String imagePath;

  const CustomCheckBox({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imagePath, scale: 4),
        sw5,
        Text(
          text,
          style: h4,
        ),
      ],
    );
  }
}