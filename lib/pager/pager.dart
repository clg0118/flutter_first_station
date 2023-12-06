import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/pager/color_selector.dart';
import 'package:flutter_first_station/pager/conform_dialog.dart';
import 'package:flutter_first_station/pager/pager_app_bar.dart';
import 'package:flutter_first_station/pager/stork_width_selector.dart';

import 'model.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  final List<Line> _lines = [];

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

  final List<Line> _historyLines = [];

  void _back() {
    Line line = _lines.removeLast();
    _historyLines.add(line);
    setState(() {});
  }

  void _revocation() {
    Line line = _historyLines.removeLast();
    _lines.add(line);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagerAppBar(
          onClear: _showClearDialog,
          onBack: _lines.isEmpty ? null : _back,
          onRevocation: _historyLines.isEmpty ? null : _revocation),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              child: CustomPaint(
                painter: PaperPainter(
                  lines: _lines,
                ),
                child:
                    ConstrainedBox(constraints: const BoxConstraints.expand()),
              )),
          Positioned(
            bottom: 40,
            child: ColorSelector(
              supportColors: supportColors,
              activeIndex: _activeColorIndex,
              onSelector: _onSelectColor,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: StorkWidthSelector(
              supportStorkWidths: supportStrokeWidth,
              activeIndex: _activeStrokeIndex,
              onSelect: _onSelectStrokeWidth,
              color: supportColors[_activeColorIndex],
            ),
          )
        ],
      ),
    );
  }

  void _onSelectColor(int index) {
    if (index != _activeColorIndex) {
      setState(() {
        _activeColorIndex = index;
      });
    }
  }

  void _onSelectStrokeWidth(int index) {
    if (index != _activeStrokeIndex) {
      setState(() {
        _activeStrokeIndex = index;
      });
    }
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
    _lines.add(Line(
        points: [details.localPosition],
        strokeWidth: supportStrokeWidth[_activeStrokeIndex],
        color: supportColors[_activeColorIndex]));
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
