import 'package:flutter/material.dart';

import '../app_text_style/styles.dart';

class CustomRow extends StatelessWidget {
  final String leftText;
  final String? rightText;

  const CustomRow({
    super.key,
    required this.leftText,
    this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: h3.copyWith(fontSize: 14)),
        if (rightText != null) Text(rightText!, style: h3.copyWith(fontSize: 14)),
      ],
    );
  }
}
