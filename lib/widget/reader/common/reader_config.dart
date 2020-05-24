import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show window;

class ReaderConfig {
  static const String offsetStart = 'start';
  static const String offsetEnd = 'end';

  MediaQueryData _mediaQuery;

  ReaderConfig._internal() {
    _mediaQuery = MediaQueryData.fromWindow(ui.window);
  }

  static ReaderConfig _instance = ReaderConfig._internal();

  static ReaderConfig get instance => _instance;

  EdgeInsetsGeometry _padding;
  double _fontSize;

  EdgeInsetsGeometry get padding {
    return _padding ?? EdgeInsets.only(
      top: _safeTopHeight,
      bottom: _safeBottomHeight,
      left: 20,
      right: 15
    );
  }

  set padding(EdgeInsetsGeometry padding) {
    this._padding = padding;
  }

  double get fontSize {
    return _fontSize ?? 16;
  }

  set fontSize(double fontSize) {
    this._fontSize = fontSize;
  }

  double get _safeTopHeight => _mediaQuery.padding.top;

  double get _safeBottomHeight => _mediaQuery.padding.bottom;

  double get height => _mediaQuery.size.height - padding.vertical;

  double get width => _mediaQuery.size.width - padding.horizontal;
}