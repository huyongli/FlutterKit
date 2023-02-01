import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show window;

class ReaderConfig {
  static const String offsetStart = 'start';
  static const String offsetEnd = 'end';

  late MediaQueryData _mediaQuery;
  double titleMargin = 10;

  ReaderConfig._internal() {
    _mediaQuery = MediaQueryData.fromWindow(ui.window);
  }

  static ReaderConfig _instance = ReaderConfig._internal();

  static ReaderConfig get instance => _instance;

  late EdgeInsetsGeometry? _padding;
  late double? _fontSize;
  late double? _titleFontSize;

  EdgeInsetsGeometry get padding {
    return _padding ?? EdgeInsets.only(
      top: _safeTopHeight,
      bottom: _safeBottomHeight,
      left: 20,
      right: 15
    );
  }

  set padding(EdgeInsetsGeometry? padding) {
    this._padding = padding;
  }

  double get fontSize {
    return _fontSize ?? 16;
  }

  set fontSize(double? fontSize) {
    this._fontSize = fontSize;
  }

  double get titleFontSize {
    return _titleFontSize ?? 16;
  }

  set titleFontSize(double? fontSize) {
    this._titleFontSize = fontSize;
  }

  double get _safeTopHeight => _mediaQuery.padding.top;

  double get _safeBottomHeight => _mediaQuery.padding.bottom;

  double get screenHeight => _mediaQuery.size.height;

  double get screenWidth => _mediaQuery.size.width;

  double get contentWidth => screenWidth - padding.horizontal;

  double get contentHeight => screenHeight - padding.vertical - titleMargin;
}