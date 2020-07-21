import 'package:example/demo/demo_page/simulation_path_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'page_painter.dart';

enum TouchArea {
  TOUCH_TOP_RIGHT,
  TOUCH_BOTTOM_RIGHT,
  TOUCH_NONE,
}

extension TouchAreaExt on TouchArea {
  DrawDelegate getDelegate(SimulationPathManager pathManager) {
    DrawDelegate delegate;
    switch (this) {
      case TouchArea.TOUCH_TOP_RIGHT:
        delegate = TouchTopRightDrawDelegate(pathManager: pathManager);
        break;
      case TouchArea.TOUCH_BOTTOM_RIGHT:
        delegate = TouchBottomRightDrawDelegate(pathManager: pathManager);
        break;
      default:
        delegate = TouchNoneDrawDelegate(pathManager: pathManager);
        break;
    }
    return delegate;
  }
}

extension PointExt on Point {
  TouchArea getTouchArea(Size size, TouchArea last) {
    TouchArea oldTouchArea = last ?? TouchArea.TOUCH_NONE;
    TouchArea newTouchArea;
    if (this.y <= size.height / 2) {
      newTouchArea = TouchArea.TOUCH_TOP_RIGHT;
    } else {
      newTouchArea = TouchArea.TOUCH_BOTTOM_RIGHT;
    }
    if (newTouchArea != oldTouchArea && oldTouchArea != TouchArea.TOUCH_NONE) {
      newTouchArea = oldTouchArea;
    }
    return newTouchArea;
  }
}

abstract class DrawDelegate {
  final SimulationPathManager pathManager;

  Point get touchPoint => pathManager.touchPoint?.clone();

  DrawDelegate({this.pathManager}) : assert(pathManager != null);

  void draw(Canvas canvas, Paint paint, Size size);
}

class TouchNoneDrawDelegate extends DrawDelegate {
  TouchNoneDrawDelegate({SimulationPathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint..color = Colors.green;
    var pathA = pathManager.getCanvasDefaultPath(size);
    canvas.drawPath(pathA, paint);
    canvas.restore();
  }
}

class TouchBottomRightDrawDelegate extends DrawDelegate {
  TouchBottomRightDrawDelegate({SimulationPathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    if (pathManager.isSimulationPath) {
      drawPathB(canvas, paint, size);
      drawPathC(canvas, paint, size);
    }
    drawPathAFromBottomRight(canvas, paint, size);
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
    var pathC = pathManager.getPathC();
    canvas.drawPath(pathC, paint);
    canvas.restore();
  }

  void drawPathAFromBottomRight(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = Colors.green
      ..blendMode = BlendMode.src;
    var pathA = pathManager.getPathAFromBottomRight(size);
    canvas.drawPath(pathA, paint);
    canvas.restore();
  }
}

class TouchTopRightDrawDelegate extends DrawDelegate {
  TouchTopRightDrawDelegate({SimulationPathManager pathManager}) : super(pathManager: pathManager);

  @override
  void draw(Canvas canvas, Paint paint, Size size) {
    if (pathManager.isSimulationPath) {
      drawPathB(canvas, paint, size);
      drawPathC(canvas, paint, size);
    }
    drawPathAFromBottomRight(canvas, paint, size);
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
    var pathC = pathManager.getPathC();
    canvas.drawPath(pathC, paint);
    canvas.restore();
  }

  void drawPathAFromBottomRight(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    paint
      ..color = Colors.green
      ..blendMode = BlendMode.src;
    var pathA = pathManager.getPathAFromBottomRight(size);
    canvas.drawPath(pathA, paint);
    canvas.restore();
  }
}
