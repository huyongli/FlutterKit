import 'dart:math' show pow;

import 'package:flutter/painting.dart';

import '../page_painter.dart';

abstract class IPathDelegate {
  /// 当前页面路径
  Path getCurrentPagePath(Size size);

  /// 翻页过程中下一页的路径
  Path getNextPagePath(Size size);

  /// 仿真翻页过程中当前页的背面路径
  Path getCurrentPageBackSidePath(Size size);

  /// 取消仿真翻页动画结束点坐标
  Point getCancelAnimationEndPoint(Size size);

  /// 自动完成仿真翻页动画的结束点坐标
  Point getStartAnimationEndPoint(Size size);
}

abstract class PathDelegate extends IPathDelegate {
  final Path _path = Path();
  late Point _ap;
  late Point _fp;
  late Point _gp;
  late Point _ep;
  late Point _hp;
  late Point _cp;
  late Point _jp;
  late Point _bp;
  late Point _kp;
  late Point _dp;
  late Point _ip;

  Point get touchPoint => _ap;

  Point getDefaultFPoint(Size size);

  void calculate(Point touchPoint, Size size) {
    _fp = getDefaultFPoint(size);
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

  Point getOverMaxXTouchPoint(Size size);

  bool isOverMaxX(Point touchPoint, Size size) {
    Point fp = getDefaultFPoint(size);
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

  @override
  Path getCurrentPageBackSidePath(Size size) {
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

  @override
  Path getNextPagePath(Size size) {
    _path
      ..reset()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return _path;
  }

  @override
  Point getCancelAnimationEndPoint(Size size) {
    return getDefaultFPoint(size);
  }

  @override
  Point getStartAnimationEndPoint(Size size) {
    return getDefaultFPoint(size) - Point(x: size.width + touchPoint.x, y: 0);
  }
}

class BottomRightPathDelegate extends PathDelegate {

  @override
  Path getCurrentPagePath(Size size) {
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

  @override
  Point getDefaultFPoint(Size size) {
    return Point(x: size.width, y: size.height);
  }

  @override
  Point getOverMaxXTouchPoint(Size size) {
    return getDefaultFPoint(size) - Point(x: 50, y: 50);
  }
}

class TopRightPathDelegate extends PathDelegate {

  @override
  Path getCurrentPagePath(Size size) {
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

  @override
  Point getDefaultFPoint(Size size) {
    return Point(x: size.width, y: 0);
  }

  @override
  Point getOverMaxXTouchPoint(Size size) {
    return getDefaultFPoint(size) - Point(x: 50, y: -50);
  }
}

class DefaultPathDelegate extends PathDelegate {
  @override
  Path getCurrentPagePath(Size size) {
    return getNextPagePath(size);
  }

  @override
  Point getDefaultFPoint(Size size) {
    return Point(x: size.width, y: size.height);
  }

  @override
  Point getOverMaxXTouchPoint(Size size) {
    return Point(x: size.width, y: size.height);
  }
}