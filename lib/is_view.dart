import 'package:flutter/material.dart';

class DrawIsView1 extends CustomPainter {
  Color color;

  DrawIsView1({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0); // 시작위치 // 0,0이면 왼쪽 위
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width - size.width * 0.45, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawIsView2 extends CustomPainter {
  Color color;

  DrawIsView2({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0); // 시작위치 // 0,0이면 왼쪽 위
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.6);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
