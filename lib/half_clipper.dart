import 'package:flutter/material.dart';

class HalfLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(HalfLeftClipper oldClipper) => false;
}

class HalfRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height / 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(HalfRightClipper oldClipper) => false;
}
