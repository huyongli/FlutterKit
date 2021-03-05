import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show window;

class ScreenUtil {
  static MediaQueryData _mediaQuery;

  static MediaQueryData getDefaultMediaQuery() {
    if (_mediaQuery == null) {
      _mediaQuery = MediaQueryData.fromWindow(ui.window);
    }
    return _mediaQuery;
  }

  /// 以下屏幕相关属性不需要[BuildContext]

  static double get width => getDefaultMediaQuery().size.width;

  static double get height => getDefaultMediaQuery().size.height;

  static double get safeTopHeight => getDefaultMediaQuery().padding.top;

  static double get safeBottomHeight => getDefaultMediaQuery().padding.bottom;

  /// 以下屏幕相关属性需要[BuildContext]

  static double getSafeTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getSafeBottomHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
