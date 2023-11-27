import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/pager/pager_app_bar.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagerAppBar(onClear: _clear),
      body: CustomPaint(
        painter: PaperPainter(),
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      ),
    );
  }

  void _clear() {}
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = const [
      Offset(100, 100),
      Offset(100, 150),
      Offset(150, 150),
      Offset(200, 100)
    ];
    Paint paint = Paint();
    paint.strokeWidth = 10;
    paint.strokeCap = StrokeCap.round;
    paint.color = Colors.blue;
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
