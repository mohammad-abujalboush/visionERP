import 'package:flutter/material.dart';

class MultiCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // ابدأ من الزاوية اليسرى العلوية
    path.lineTo(0, size.height - 50);

    // إنشاء موجات صغيرة متكررة (5 موجات)
    final waveCount = 3;
    final waveWidth = size.width / waveCount;

    for (int i = 0; i < waveCount; i++) {
      final isEven = i.isEven;
      final controlPointX = waveWidth * i + waveWidth / 2;
      final controlPointY = isEven
          ? size.height - 80 // الموجة للأعلى قليلاً
          : size.height - 30; // الموجة للأسفل قليلاً
      final endPointX = waveWidth * (i + 1);
      final endPointY = size.height - 50;
      path.quadraticBezierTo(controlPointX, controlPointY, endPointX, endPointY);
    }

    // إغلاق الشكل
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
