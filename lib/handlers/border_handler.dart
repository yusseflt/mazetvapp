import 'package:flutter/material.dart';

class BorderHandler extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);

    path.lineTo(size.width / 1.1, size.height);

    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 30);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BorderHandler oldClipper) => false;
}
