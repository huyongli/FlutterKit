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

  Point get touchPoint => _currentPathDelegate.touchPoint;

  PathDelegate _getPathCalculator(TouchArea touchArea) {
    assert(touchArea != null);
    if (_cachePathDelegate[touchArea] == null) {
      _cachePathDelegate[touchArea] = touchArea.createPathCalculator();
    }
    return _cachePathDelegate[touchArea];
  }

  TouchArea calculate(Point touchPoint, Size size) {
    _touchArea = touchPoint.getTouchArea(size, this.touchArea);
    _currentPathDelegate = _getPathCalculator(touchArea);
    bool isOver = _currentPathDelegate.isOverMaxX(touchPoint, size);
    Point base = isOver
        ? (this.touchPoint == null ? Point(x: size.width, y: size.height) - Point(x: 50, y: 50) : this.touchPoint)
        : touchPoint;
    _currentPathDelegate.calculate(base, size);
    return touchArea;
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
}