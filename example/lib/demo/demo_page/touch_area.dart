import 'package:flutter/painting.dart';

import 'draw_delegate.dart';
import 'page_painter.dart';
import 'path/path_delegate.dart';
import 'path/path_manager.dart';

enum TouchAction {
  ActionDown,
  ActionMove,
  ActionUp
}

enum TouchArea {
  TOUCH_TOP_RIGHT,
  TOUCH_BOTTOM_RIGHT,
  TOUCH_NONE,
}

extension TouchAreaExt on TouchArea {
  DrawDelegate createDelegate(PathManager pathManager) {
    DrawDelegate delegate;
    switch (this) {
      case TouchArea.TOUCH_NONE:
        delegate = DefaultDrawDelegate(pathManager: pathManager);
        break;
      default:
        delegate = TouchDrawDelegate(pathManager: pathManager);
        break;
    }
    return delegate;
  }

  PathDelegate createPathCalculator() {
    PathDelegate calculator;
    switch (this) {
      case TouchArea.TOUCH_TOP_RIGHT:
        calculator = TopRightPathDelegate();
        break;
      case TouchArea.TOUCH_BOTTOM_RIGHT:
        calculator = BottomRightPathDelegate();
        break;
      default:
        calculator = DefaultPathDelegate();
        break;
    }
    return calculator;
  }
}

extension PointExt on Point {
  TouchArea getTouchArea(Size size, TouchArea last) {
    TouchArea oldTouchArea = last ?? TouchArea.TOUCH_NONE;
    TouchArea newTouchArea;
    if (this.y <= size.height / 2) {
      newTouchArea = TouchArea.TOUCH_TOP_RIGHT;
    } else {
      newTouchArea = TouchArea.TOUCH_BOTTOM_RIGHT;
    }
    if (newTouchArea != oldTouchArea && oldTouchArea != TouchArea.TOUCH_NONE) {
      newTouchArea = oldTouchArea;
    }
    return newTouchArea;
  }
}