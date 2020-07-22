import 'package:flutter/painting.dart';

import '../page_painter.dart';
import '../touch_area.dart';
import 'default_path_delegate.dart';
import 'path_delegate.dart';

class PathManager extends IPathDelegate {
  Map<TouchArea, PathDelegate> _cachePathDelegate = {};
  PathDelegate _currentPathDelegate = DefaultPathDelegate();

  TouchArea _touchArea;

  TouchArea get touchArea => _touchArea;
  
  set touchArea(TouchArea touchArea) {
    this._touchArea = touchArea;
    _currentPathDelegate = touchArea.createPathCalculator();
  }

  Point get touchPoint => _currentPathDelegate.touchPoint;

  void setTouchAreaByTouchPoint(Point touchPoint, Size size) {
    this.touchArea = touchPoint.getTouchArea(size, this.touchArea);
  }

  void restoreDefault() {
    this.touchArea = TouchArea.TOUCH_NONE;
    this._currentPathDelegate.restore();
  }

  void calculate(Point touchPoint, Size size) {
    if (touchArea == TouchArea.TOUCH_NONE) {
      return;
    }
    bool isOver = _currentPathDelegate.isOverMaxX(touchPoint, size);
    Point base = isOver
        ? (this.touchPoint == null ? _currentPathDelegate.getOverMaxXTouchPoint(size) : this.touchPoint)
        : touchPoint;
    _currentPathDelegate.calculate(base, size);
  }

  @override
  Path getPathA(Size size) {
    return _currentPathDelegate.getPathA(size);
  }

  @override
  Path getPathB(Size size) {
    return _currentPathDelegate.getPathB(size);
  }

  @override
  Path getPathC(Size size) {
    return _currentPathDelegate.getPathC(size);
  }

  @override
  Path getDefaultPath(Size size) {
    return _currentPathDelegate.getDefaultPath(size);
  }

  Point getDefaultFPoint(Size size) {
    return _currentPathDelegate.getDefaultFPoint(size);
  }
}
