import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(500, 0),
      [
        Color(0xff2699FB),
        Color(0xff2F4360),

      ],
    );

    double appBarH = 50;

    double goToX1 = size.width * 0.50;
    double goToY1 = appBarH;
    double througX1 = size.width * 0.30;
    double througY1 = appBarH + 15;

    double goToX2 = size.width * 0.65;
    double goToY2 = appBarH;
    double througX2 = size.width * 0.58;
    double througY2 = appBarH - 5;

    double goToX3 = size.width;
    double goToY3 = appBarH;
    double througX3 = size.width * 0.80;
    double througY3 = appBarH + 15;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 50)
      ..quadraticBezierTo(througX1, througY1, goToX1, goToY1)
      ..quadraticBezierTo(througX2, througY2, goToX2, goToY2)
      ..quadraticBezierTo(througX3, througY3, goToX3, goToY3)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}