import 'package:example/demo/demo_page/simulation_path_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 仿真绘制原理：https://blog.csdn.net/hmg25/article/details/6306479
/// 仿真实现参考：https://juejin.im/post/5a3215c96fb9a045186ac0fe
/// 直线表示方式：y=a*x+b, 已知两点：(x1, y1), (x2, y2), 通过该两点的直线则为：
/// a=(y2-y1)/(x2-x1), b=(x2*y1-x1*y2)/(x2-x1)
///
/// 如果有两条直线相交于同一点，则两条直接可表示为：y=a1*x+b1, y=a2*x+b2，计算相交点坐标为：
/// x=(b2-b1)/(a1-a2), y=a1*x+b1
/// 将x表达式代入y表达式中可得：y=((a1*b2-a1*b1) + (a1*b1-a2*b1))/(a1-a2)=(a1*b2-a2*b1)/(a1-a2)
class PagePainter extends CustomPainter {
  final Point _touchPoint;
  final Paint _drawPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  final SimulationPathManager _pathManager;

  PagePainter({SimulationPathManager pathManager})
      : _touchPoint = pathManager.touchPoint?.clone(),
        _pathManager = pathManager,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    if (_pathManager.isSimulationPath) {
      drawPathB(canvas, size);
      drawPathC(canvas, size);
    }
    drawPathAFromBottomRight(canvas, size);
  }

  void drawPathB(Canvas canvas, Size size) {
    canvas.save();
    _drawPaint
      ..color = Colors.blue
      ..blendMode = BlendMode.srcOver;
    var pathB = _pathManager.getPathB(size);
    canvas.drawPath(pathB, _drawPaint);
    canvas.restore();
  }

  void drawPathC(Canvas canvas, Size size) {
    canvas.save();
    _drawPaint..color = Colors.yellow;
    var pathC = _pathManager.getPathC();
    canvas.drawPath(pathC, _drawPaint);
    canvas.restore();
  }

  void drawPathAFromBottomRight(Canvas canvas, Size size) {
    canvas.save();
    _drawPaint
      ..color = Colors.green
      ..blendMode = BlendMode.src;
    var pathA = _pathManager.getPathAFromBottomRight(size);
    canvas.drawPath(pathA, _drawPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is PagePainter && oldDelegate._touchPoint != _touchPoint;
  }
}

class Line {
  Point p1;
  Point p2;

  Line(this.p1, this.p2);

  @override
  String toString() {
    return 'Line($p1, $p2)';
  }
}

class Point {
  double x;
  double y;

  Point({this.x, this.y});

  Offset get offset => Offset(x, y);

  bool get isNull => x == null || y == null;

  Point operator +(Point other) => Point(x: x + other.x, y: y + other.y);

  Point operator -(Point other) => Point(x: x - other.x, y: y - other.y);

  Point clone() => Point(x: x, y: y);

  @override
  bool operator ==(dynamic other) {
    return other is Point && x == other.x && y == other.y;
  }

  @override
  int get hashCode => hashValues(x, y);

  @override
  String toString() {
    return 'Point($x, $y)';
  }
}
