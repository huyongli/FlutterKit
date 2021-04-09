import 'package:flutter/material.dart';

class DirectionSlideTransition extends AnimatedWidget {
  final bool transformHitTests;
  final Widget? child;
  Animation<double> get position => listenable as Animation<double>;
  final AxisDirection direction; /// 退(出)场方向
  late final Tween<Offset> _tween;

  DirectionSlideTransition({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child
  }): super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}