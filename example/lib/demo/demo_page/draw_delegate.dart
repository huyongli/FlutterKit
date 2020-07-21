import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'page_painter.dart';
import 'path/path_manager.dart';

abstract class DrawDelegate {
  final PathManager pathManager;

  Point get touchPoint => pathManager.touchPoint?.clone();

  DrawDelegate({this.pathManager}) : assert(pathManager != null);

  void draw(Canvas canvas, Paint paint, Size size);
}

class DefaultDrawDelegate extends DrawDelegate {
  DefaultDrawDelegate({PathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint..color = Colors.green;
    var defaultPath = pathManager.getDefaultPath(size);
    canvas.drawPath(defaultPath, paint);
    canvas.restore();
  }
}

class TouchDrawDelegate extends DrawDelegate {
  TouchDrawDelegate({PathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    drawPathB(canvas, paint, size);
    drawPathC(canvas, paint, size);
    drawPathA(canvas, paint, size);
  }

  void drawPathB(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = Colors.blue
      ..blendMode = BlendMode.srcOver;
    var pathB = pathManager.getPathB(size);
    canvas.drawPath(pathB, paint);
    canvas.restore();
  }

  void drawPathC(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint..color = Colors.yellow;
    var pathC = pathManager.getPathC(size);
    canvas.drawPath(pathC, paint);
    canvas.restore();
  }

  void drawPathA(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = Colors.green
      ..blendMode = BlendMode.src;
    var pathA = pathManager.getPathA(size);
    canvas.drawPath(pathA, paint);
    canvas.restore();
  }
}