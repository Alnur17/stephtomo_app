import 'package:flutter/material.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.bottomBackColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo(size.width * 0.40, 0);

    path.arcTo(
      Rect.fromCircle(
        center: Offset(size.width * 0.5, 18),
        radius: 39,
      ),
      4.14, // Start angle (half-circle start)
      -5.14, // Sweep angle (counter-clockwise to "cut out")
      false,
    );

    path.lineTo(size.width * 0.60, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
