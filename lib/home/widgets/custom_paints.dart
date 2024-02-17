import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final path = Path()
      ..lineTo(0, height - 100)
      ..quadraticBezierTo(width / 2, height - 10, width, height - 100)
      ..lineTo(width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomShapeBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path()
      ..moveTo(1, 0) // 1 pixel to the right
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 100)
      ..moveTo(size.height - 100, size.width)
      ..moveTo(size.width, size.height - 100)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
