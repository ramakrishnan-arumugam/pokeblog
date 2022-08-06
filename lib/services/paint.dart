import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint backColor = Paint()..color = const Color(0xff18b0e8);
    Paint backColor = Paint()..color = Colors.tealAccent.shade700; //  0xffab47bc
    Paint circles = Paint()..color = Colors.white.withAlpha(40);

    canvas.drawRect(
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(size.width, size.height),
      ),
      backColor,
    );

    canvas.drawCircle(Offset(size.width * .65, 10), 30, circles);
    canvas.drawCircle(Offset(size.width * .60, 130), 10, circles);
    // canvas.drawCircle(Offset(size.width - 10, size.height - 10), 20, circles);

    canvas.drawCircle(Offset(size.width - 205, size.height - 500), 90, circles);
    canvas.drawCircle(Offset(size.width - 55, size.height - 400), 40, circles);
    canvas.drawCircle(Offset(size.width - 255, size.height - 650), 30, circles);
    canvas.drawCircle(Offset(size.width - 370, size.height - 720), 25, circles);
    canvas.drawCircle(Offset(size.width - 225, size.height - 300), 35, circles);
    canvas.drawCircle(Offset(size.width - 375, size.height - 450), 20, circles);
    canvas.drawCircle(Offset(size.width - 305, size.height - 350), 40, circles);
    canvas.drawCircle(Offset(size.width - 45, size.height - 700), 70, circles);
    //

    canvas.drawCircle(Offset(size.width - 35, size.height - 80), 170, circles);
    canvas.drawCircle(Offset(size.width - 320, size.height - 220), 55, circles);
    canvas.drawCircle(Offset(size.width - 290, size.height - 100), 30, circles);
    canvas.drawCircle(Offset(size.width - 100, size.height - 350), 70, circles);
    canvas.drawCircle(Offset(size.width - 300, size.height - 580), 60, circles);
    canvas.drawCircle(Offset(size.width - 55, size.height - 665), 30, circles);
    canvas.drawCircle(Offset(size.width - 70, size.height - 520), 25, circles);
    // canvas.drawCircle(Offset(size.width - 225, size.height - 300), 35, circles);
    // canvas.drawCircle(Offset(size.width - 375, size.height - 450), 25, circles);
    // canvas.drawCircle(Offset(size.width - 305, size.height - 350), 40, circles);
    // canvas.drawCircle(Offset(size.width - 45, size.height - 700), 35, circles);
    //
    //
    // canvas.drawCircle(Offset(size.width - 305, size.height - 80), 30, circles);
    // canvas.drawCircle(Offset(size.width - 350, size.height - 180), 20, circles);
    // canvas.drawCircle(Offset(size.width - 100, size.height - 100), 15, circles);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
