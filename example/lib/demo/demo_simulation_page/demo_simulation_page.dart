import 'package:example/demo/demo_simulation_page/demo_simulation_viewmodel.dart';
import 'package:example/demo/demo_simulation_page/draw_delegate.dart';
import 'package:example/demo/demo_simulation_page/page_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/util/screen_util.dart';

import 'path/path_manager.dart';
import 'touch_area.dart';

/// https://juejin.im/post/5a3215c96fb9a045186ac0fe
class DemoSimulationPage extends StatefulWidget {
  @override
  _DemoSimulationPageState createState() => _DemoSimulationPageState();
}

class _DemoSimulationPageState extends State<DemoSimulationPage> with SingleTickerProviderStateMixin {
  final SimulationViewModel viewModel = SimulationViewModel();

  AnimationController _controller;
  Animation<Point> _animation;
  bool _isAnimating = false;

  final PathManager pathManager = PathManager(color: PathColor());
  DrawDelegate currentDrawDelegate;

  @override
  void initState() {
    super.initState();
    currentDrawDelegate = TouchArea.TOUCH_NONE.createDelegate(pathManager);
    _controller = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Listener(
        onPointerDown: (event) {
          onTouch(event, TouchAction.ActionDown);
        },
        onPointerMove: (event) {
          onTouch(event, TouchAction.ActionMove);
        },
        onPointerUp: (event) {
          onTouch(event, TouchAction.ActionUp);
        },
        child: CustomPaint(
          painter: PagePainter(drawDelegate: currentDrawDelegate),
          size: ScreenUtil.getDefaultMediaQuery().size,
        ),
      ),
    );
  }

  void onTouch(event, TouchAction action) {
    if (_isAnimating) {
      return;
    }
    var size = ScreenUtil.getDefaultMediaQuery().size;
    Point touchPoint = Point(x: event.localPosition.dx, y: event.localPosition.dy);
    switch (action) {
      case TouchAction.ActionDown:
        pathManager.setTouchAreaByTouchPoint(touchPoint, size);
        setCurrentTouchPoint(touchPoint, size, true);
        break;
      case TouchAction.ActionMove:
        setCurrentTouchPoint(touchPoint, size, true);
        break;
      case TouchAction.ActionUp:
        startAnimation(size);
        break;
    }
  }

  void setCurrentTouchPoint(Point touchPoint, Size size, bool isTouched) {
    Point diff = touchPoint - pathManager.touchPoint;
    if (!(diff.x.abs() >= 0.1 || diff.y.abs() >= 0.1)) {
      return;
    }
    pathManager.calculate(touchPoint, size, isTouched);
    refresh();
  }

  void refresh() {
    setState(() {
      currentDrawDelegate = pathManager.touchArea.createDelegate(pathManager);
    });
  }

  void startAnimation(Size size, {bool isRestore = false}) {
    var begin = pathManager.touchPoint;
    if (begin == null) {
      return;
    }
    _controller.reset();
    var end = isRestore ? pathManager.getCancelAnimationEndPoint(size) : pathManager.getStartAnimationEndPoint(size);
    _animation = Tween<Point>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 1),
      ),
    )
      ..addListener(() {
        setCurrentTouchPoint(_animation.value, size, false);
        if (end == _animation.value) {
          pathManager.restoreDefault();
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isAnimating = false;
          refresh();
        }
      });
    _isAnimating = true;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
