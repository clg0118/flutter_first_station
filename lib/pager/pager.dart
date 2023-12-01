import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/pager/conform_dialog.dart';
import 'package:flutter_first_station/pager/pager_app_bar.dart';

import 'model.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  List<Line> _lines = [];

  int _activeColorIndex = 0;
  int _activeStrokeIndex = 0;

  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];

  final List<double> supportStrokeWidth = [1, 2, 4, 6, 8, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagerAppBar(onClear: _showClearDialog),
      body: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          child: CustomPaint(
            painter: PaperPainter(
              lines: _lines,
            ),
            child: ConstrainedBox(constraints: const BoxConstraints.expand()),
          )),
    );
  }

  void _showClearDialog() {
    String msg = '您的当前操作会清空绘制内容，是否确定删除!';
    showDialog(
        context: context,
        builder: (ctx) =>
            ConformDialog(title: '清空提示', msg: msg, onConform: _clear));
  }

  void _clear() {
    _lines.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(Line(points: [details.localPosition]));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _lines.last.points.add(details.localPosition);
    setState(() {});
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final List<Line> lines;

  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      drawLine(canvas, line);
    }
  }

  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
