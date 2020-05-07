import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey.shade100;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 1);

    path.quadraticBezierTo(size.width * 0.02, size.height * 0.905,
        size.width * 0.13, size.height * 0.905);

    path.lineTo(size.width * 0.87, size.height * 0.905);

    path.quadraticBezierTo(size.width * 0.98, size.height * 0.905,
        size.width * 1.0, size.height * 0.85);
    path.lineTo(size.width, size.height*1.0);
    path.lineTo(0, size.height*1.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}