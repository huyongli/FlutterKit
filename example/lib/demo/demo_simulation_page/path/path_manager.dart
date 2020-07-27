import 'package:example/demo/demo_simulation_page/page_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../page_painter.dart';
import '../touch_area.dart';
import 'path_delegate.dart';

class PathColor {
  final Color curPageBgColor;
  final Color nextPageBgColor;
  final Color curPageBackSideBgColor;

  PathColor({
    this.curPageBgColor = Colors.green,
    this.nextPageBgColor = Colors.blue,
    this.curPageBackSideBgColor = Colors.yellow,
  });
}

class PathManager extends IPathDelegate {
  PathColor color;
  List<PageCanvasEntity> contents;

  PathDelegate _currentPathDelegate = DefaultPathDelegate();

  TouchArea _touchArea;

  TouchArea get touchArea => _touchArea;
  
  set touchArea(TouchArea touchArea) {
    this._touchArea = touchArea;
    _currentPathDelegate = touchArea.createPathCalculator();
  }

  Point get touchPoint => _currentPathDelegate.touchPoint;

  PathManager({@required this.color}): assert(color != null);

  void setTouchAreaByTouchPoint(Point touchPoint, Size size) {
    this.touchArea = touchPoint.getTouchArea(size, this.touchArea);
  }

  void restoreDefault() {
    this.touchArea = TouchArea.TOUCH_NONE;
  }

  void calculate(Point touchPoint, Size size, bool isTouched) {
    if (touchArea == TouchArea.TOUCH_NONE) {
      return;
    }
    bool isOver = _currentPathDelegate.isOverMaxX(touchPoint, size);
    Point base = isTouched && isOver
        ? (this.touchPoint == null ? _currentPathDelegate.getOverMaxXTouchPoint(size) : this.touchPoint)
        : touchPoint;
    _currentPathDelegate.calculate(base, size);
  }

  @override
  Path getCurrentPagePath(Size size) {
    return _currentPathDelegate.getCurrentPagePath(size);
  }

  @override
  Path getNextPagePath(Size size) {
    return _currentPathDelegate.getNextPagePath(size);
  }

  @override
  Path getCurrentPageBackSidePath(Size size) {
    return _currentPathDelegate.getCurrentPageBackSidePath(size);
  }

  @override
  Point getCancelAnimationEndPoint(Size size) {
    return _currentPathDelegate.getCancelAnimationEndPoint(size);
  }

  @override
  Point getStartAnimationEndPoint(Size size) {
    return _currentPathDelegate.getStartAnimationEndPoint(size);
  }
}
