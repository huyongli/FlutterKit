import 'dart:developer';

import 'package:example/demo/demo_page/page_painter.dart';
import 'package:example/demo/demo_page/simulation_path_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/util/screen_util.dart';

/// https://juejin.im/post/5a3215c96fb9a045186ac0fe
class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final SimulationPathManager pathManager = SimulationPathManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Listener(
        onPointerDown: (event) {
          onTouch(event);
        },
        onPointerMove: (event) {
          onTouch(event);
        },
        child: CustomPaint(
          painter: PagePainter(pathManager: pathManager),
          size: ScreenUtil.getDefaultMediaQuery().size,
        ),
      ),
    );
  }

  void onTouch(event) {
    var size = ScreenUtil.getDefaultMediaQuery().size;
    Point touchPoint = Point(x: event.localPosition.dx, y: event.localPosition.dy);
    if (pathManager.calculatePointC(touchPoint, size).x >= 0) {
      pathManager.calculate(touchPoint, size);
    } else {
      pathManager.calculate(pathManager.touchPoint, size);
    }
    log('touch: $touchPoint');
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
