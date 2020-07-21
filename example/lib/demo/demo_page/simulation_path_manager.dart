import 'dart:math' show pow, sqrt;

import 'package:flutter/painting.dart';

import 'draw_delegate.dart';
import 'page_painter.dart';

class SimulationPathManager {
  final Path _path = Path();
  Point _ap;
  Point _fp;
  Point _gp;
  Point _ep;
  Point _hp;
  Point _cp;
  Point _jp;
  Point _bp;
  Point _kp;
  Point _dp;
  Point _ip;
  TouchArea _touchArea;

  TouchArea get touchArea => _touchArea;

  Point get touchPoint => _ap;

  bool get isSimulationPath => !(touchPoint?.isNull ?? true);

  TouchArea calculate(Point touchPoint, Size size) {
    TouchArea touchArea = touchPoint.getTouchArea(size, this.touchArea);
    bool isOver = isOverMaxX(touchPoint, size, touchArea);
    Point base = isOver
        ? (this.touchPoint == null ? Point(x: size.width, y: size.height) - Point(x: 50, y: 50) : this.touchPoint)
        : touchPoint;
    calculateInternal(base, size, touchArea);
    return touchArea;
  }

  void calculateInternal(Point touchPoint, Size size, TouchArea touchArea) {
    _touchArea = touchArea;
    switch (touchArea) {
      case TouchArea.TOUCH_TOP_RIGHT:
        _fp = Point(x: size.width, y: 0);
        break;
      default:
        _fp = Point(x: size.width, y: size.height);
        break;
    }
    _ap = touchPoint;

    _gp = Point()
      ..x = (_ap.x + _fp.x) / 2
      ..y = (_ap.y + _fp.y) / 2;

    _ep = Point()
      ..x = _gp.x - pow(_fp.y - _gp.y, 2) / (_fp.x - _gp.x)
      ..y = _fp.y;

    _hp = Point()
      ..x = _fp.x
      ..y = _gp.y - pow(_fp.x - _gp.x, 2) / (_fp.y - _gp.y);

    _cp = Point()
      ..x = _ep.x - (_fp.x - _ep.x) / 2
      ..y = _fp.y;

    _jp = Point()
      ..x = _fp.x
      ..y = _hp.y - (_fp.y - _hp.y) / 2;

    _bp = getIntersectionPoint(Line(_ap, _ep), Line(_cp, _jp));
    _kp = getIntersectionPoint(Line(_ap, _hp), Line(_cp, _jp));

    _dp = Point()
      ..x = ((_cp.x + _bp.x) / 2 + _ep.x) / 2
      ..y = ((_cp.y + _bp.y) / 2 + _ep.y) / 2;

    _ip = Point()
      ..x = ((_jp.x + _kp.x) / 2 + _hp.x) / 2
      ..y = ((_jp.y + _kp.y) / 2 + _hp.y) / 2;
  }

  bool isOverMaxX(Point touchPoint, Size size, TouchArea touchArea) {
    Point fp;
    switch (touchArea) {
      case TouchArea.TOUCH_TOP_RIGHT:
        fp = Point(x: size.width, y: 0);
        break;
      default:
        fp = Point(x: size.width, y: size.height);
        break;
    }
    Point ap = touchPoint;

    Point gp = Point()
      ..x = (ap.x + fp.x) / 2
      ..y = (ap.y + fp.y) / 2;

    Point ep = Point()
      ..x = gp.x - pow(fp.y - gp.y, 2) / (fp.x - gp.x)
      ..y = fp.y;

    Point cp = Point()
      ..x = ep.x - (fp.x - ep.x) / 2
      ..y = fp.y;
    return cp.x < 0;
  }

  /// 计算两条线段的相交点坐标
  Point getIntersectionPoint(Line l1, Line l2) {
    if (l1.p1.x == l1.p2.x) {
      return Point(x: l1.p1.x, y: (l1.p1.y + l1.p2.y) / 2);
    }
    if (l2.p1.x == l1.p2.x) {
      return Point(x: l2.p1.x, y: (l2.p1.y + l2.p2.y) / 2);
    }
    double a1 = (l1.p2.y - l1.p1.y) / (l1.p2.x - l1.p1.x);
    double b1 = (l1.p2.x * l1.p1.y - l1.p1.x * l1.p2.y) / (l1.p2.x - l1.p1.x);

    double a2 = (l2.p2.y - l2.p1.y) / (l2.p2.x - l2.p1.x);
    double b2 = (l2.p2.x * l2.p1.y - l2.p1.x * l2.p2.y) / (l2.p2.x - l2.p1.x);

    double x = (b2 - b1) / (a1 - a2);
    double y = a1 * x + b1;
    return Point(x: x, y: y);
  }

  Path getPathAFromTopRight(Size size) {
    _path
      ..reset()

      ///移动到左上角
      ..moveTo(0, 0)

      /// 移动到C点
      ..lineTo(_cp.x, _cp.y)

      /// 从C点到B点画贝赛尔曲线，控制点为E点
      ..quadraticBezierTo(_ep.x, _ep.y, _bp.x, _bp.y)

      /// 移动到A点
      ..lineTo(_ap.x, _ap.y)

      /// 移动到K点
      ..lineTo(_kp.x, _kp.y)

      /// 从K点到J点画贝赛尔曲线，控制点为H点
      ..quadraticBezierTo(_hp.x, _hp.y, _jp.x, _jp.y)

      /// 移动到右下角
      ..lineTo(size.width, size.height)

      /// 移动到左下角
      ..lineTo(0, size.height)

      /// 闭合区域
      ..close();
    return _path;
  }

  /// 获取触摸点在右下角的A区域
  Path getPathAFromBottomRight(Size size) {
    _path
      ..reset()

      /// 移动到左上角
      ..moveTo(0, 0)

      /// 移动到左下角
      ..lineTo(0, size.height)

      /// 移动到C点
      ..lineTo(_cp.x, _cp.y)

      /// 从C点到B点画贝赛尔曲线，控制点为E点
      ..quadraticBezierTo(_ep.x, _ep.y, _bp.x, _bp.y)

      /// 移动到A点
      ..lineTo(_ap.x, _ap.y)

      /// 移动到K点
      ..lineTo(_kp.x, _kp.y)

      /// 从K点到J点画贝赛尔曲线，控制点为H点
      ..quadraticBezierTo(_hp.x, _hp.y, _jp.x, _jp.y)

      /// 移动到右上角
      ..lineTo(size.width, 0)

      /// 闭合区域
      ..close();

    return _path;
  }

  /// 画布默认区域
  Path getCanvasDefaultPath(Size size) {
    _path
      ..reset()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return _path;
  }

  Path getPathC() {
    _path
      ..reset()
      ..moveTo(_ip.x, _ip.y)
      ..lineTo(_kp.x, _kp.y)
      ..lineTo(_ap.x, _ap.y)
      ..lineTo(_bp.x, _bp.y)
      ..lineTo(_dp.x, _dp.y)
      ..close();
    return _path;
  }

  Path getPathB(Size size) {
    _path
      ..reset()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return _path;
  }
}
