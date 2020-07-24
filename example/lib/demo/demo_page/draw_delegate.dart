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
    paint..color = pathManager.color.curPageBgColor;
    var defaultPath = pathManager.getCurrentPagePath(size);
    canvas.drawPath(defaultPath, paint);
    canvas.restore();
  }
}

class TouchDrawDelegate extends DrawDelegate {
  TouchDrawDelegate({PathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    if (pathManager.touchPoint == null) {
      return;
    }
    drawNextPagePath(canvas, paint, size);
    drawCurrentPageBackSidePath(canvas, paint, size);
    drawCurrentPagePath(canvas, paint, size);
  }

  void drawNextPagePath(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = pathManager.color.nextPageBgColor
      ..blendMode = BlendMode.srcOver;
    var path = pathManager.getNextPagePath(size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void drawCurrentPageBackSidePath(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint..color = pathManager.color.curPageBackSideBgColor;
    var path = pathManager.getCurrentPageBackSidePath(size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void drawCurrentPagePath(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = pathManager.color.curPageBgColor
      ..blendMode = BlendMode.src;
    var path = pathManager.getCurrentPagePath(size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
