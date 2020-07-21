import 'package:example/demo/demo_page/draw_delegate.dart';
import 'package:example/demo/demo_page/page_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/util/screen_util.dart';

import 'path/path_manager.dart';
import 'touch_area.dart';

/// https://juejin.im/post/5a3215c96fb9a045186ac0fe
class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final PathManager pathManager = PathManager();
  DrawDelegate currentDrawDelegate;

  @override
  void initState() {
    super.initState();
    currentDrawDelegate = TouchArea.TOUCH_NONE.createDelegate(pathManager);
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
          painter: PagePainter(drawDelegate: currentDrawDelegate),
          size: ScreenUtil.getDefaultMediaQuery().size,
        ),
      ),
    );
  }

  void onTouch(event) {
    var size = ScreenUtil.getDefaultMediaQuery().size;
    Point touchPoint = Point(x: event.localPosition.dx, y: event.localPosition.dy);
    TouchArea touchArea = pathManager.calculate(touchPoint, size);
    setState(() {
      currentDrawDelegate = touchArea.createDelegate(pathManager);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
