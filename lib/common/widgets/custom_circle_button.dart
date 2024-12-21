import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final Color backgroundColor;

  const CustomCircleButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: backgroundColor,
        ),
        child: Image.asset(
          imagePath,
          scale: 4,
        ),
      ),
    );
  }
}
