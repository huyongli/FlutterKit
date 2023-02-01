import 'package:flutter/material.dart';
import 'package:laohu_kit/components/animation/direction_slide_transition.dart';

import '../common/common_page.dart';

class DemoAnimatedSwitcher extends StatefulWidget {

  @override
  _DemoAnimatedSwitcherState createState() => _DemoAnimatedSwitcherState();
}

class _DemoAnimatedSwitcherState extends State<DemoAnimatedSwitcher> {
  int _currentPage = 1;
  bool _isBack = false;
  int _count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage.builder(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: Container(
          key: ValueKey(_currentPage),
          alignment: Alignment.center,
          color: _currentPage == 1 ? Colors.lightGreen : Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text(_currentPage == 1 ? 'Go' : 'Back'),
                onPressed: () {
                  setState(() {
                    _isBack = _currentPage != 1;
                    _currentPage = -_currentPage;
                  });
                },
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Text('$_count', key: ValueKey(_count), style: TextStyle(fontSize: 18)),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  late AxisDirection direction;
                  switch (_count % 4) {
                    case 0:
                      direction = AxisDirection.up;
                      break;
                    case 1:
                      direction = AxisDirection.right;
                      break;
                    case 2:
                      direction = AxisDirection.down;
                      break;
                    case 3:
                      direction = AxisDirection.left;
                      break;
                  }
                  return DirectionSlideTransition(
                    child: child,
                    position: animation,
                    direction: direction
                  );
                }
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('计数'),
                onPressed: () {
                  setState(() {
                    _count = _count + 1;
                  });
                },
              )
            ],
          ),
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
          return MySlideTransition(
            child: child,
            position: tween.animate(animation),
            isBack: _isBack,
          );
        },
      ),
      title: 'AnimatedSwitcher实现路由动画'
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MySlideTransition extends AnimatedWidget {
  final bool transformHitTests;
  final Widget child;
  Animation<Offset> get position => listenable as Animation<Offset>;
  final bool isBack;

  MySlideTransition({
    super.key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    required this.isBack,
    required this.child
  }): super(listenable: position);

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse && isBack == false) {
      offset = Offset(-offset.dx, offset.dy);
    }
    if (position.status == AnimationStatus.forward && isBack) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}