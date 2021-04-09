import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show TextHeightBehavior, LineMetrics;

class TextMeasurer {
  TextPainter _textPainter;
  InlineSpan? _text;
  double? _maxWidth;
  double? _minWidth;
  bool _needMeasured = false;

  TextMeasurer({
    InlineSpan? text,
    int? maxLines,
    double? maxWidth,
    double? minWidth,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
    double textScaleFactor = 1.0,
    String? ellipsis,
    Locale? locale,
    StrutStyle? strutStyle,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    ui.TextHeightBehavior? textHeightBehavior,
  })  : _textPainter = TextPainter(
          text: text,
          maxLines: maxLines,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          ellipsis: ellipsis,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        ),
        _text = text,
        _maxWidth = maxWidth,
        _minWidth = minWidth;

  void measure({InlineSpan? text, double? maxWidth, double? minWidth}) {
    this._text = text ?? _text;
    assert(_text != null);
    assert ((maxWidth ?? _maxWidth) != null);
    _textPainter.text = _text;
    _textPainter.layout(maxWidth: (maxWidth ?? _maxWidth)!, minWidth: minWidth ?? _minWidth ?? 0.0);
    _needMeasured = true;
  }

  /// 在指定的限制条件下，当前文本是否超过指定的最大行数
  bool get didExceedMaxLines {
    assert(_needMeasured);
    return _textPainter.didExceedMaxLines;
  }

  /// 获取在指定的条件下，测量出该文本的展示所需的尺寸范围
  Size get textRect {
    assert(_needMeasured);
    return _textPainter.size;
  }

  /// 测量文本的行高
  double get lineHeight {
    assert(_needMeasured);
    var lineMetrics = _textPainter.computeLineMetrics();
    return lineMetrics.isNotEmpty ? lineMetrics[0].height : _text?.style?.fontSize ?? 0;
  }

  /// 文本在指定宽度下需要展示多少行
  int get lines {
    assert(_needMeasured);
    var lineMetrics = _textPainter.computeLineMetrics();
    return lineMetrics?.length ?? 0;
  }
  
  /// 获取布局完所有文本时，每行的相关信息
  List<ui.LineMetrics> get lineMetrics {
    assert(_needMeasured);
    return _textPainter.computeLineMetrics();
  }

  /// 展示完所有文本所需要的实际高度
  double get allLayoutHeight {
    assert(_needMeasured);
    return (lineHeight ?? 0) * (lines ?? 0);
  }

  /// 根据给定像素偏移量，获取该偏移量在文本中的位置
  TextPosition getTextPositionForOffset(Offset pixOffset) {
    assert(_needMeasured);
    return _textPainter.getPositionForOffset(pixOffset);
  }

  /// 根据给定的偏移量获取该偏移量所在行的文本索引范围
  TextRange getLineBoundary(TextPosition position) {
    assert(_needMeasured);
    return _textPainter.getLineBoundary(position);
  }

  /// 根据文本位置偏移量，获取输入光标能最靠近该偏移量前的偏移量
  /// @return offset
  int? getOffsetBefore(int textOffset) {
    assert(_needMeasured);
    return _textPainter.getOffsetBefore(textOffset);
  }

  /// 根据文本位置偏移量，获取输入光标能最靠近该偏移量后的偏移量
  /// @return offset
  int? getOffsetAfter(int textOffset) {
    assert(_needMeasured);
    return _textPainter.getOffsetAfter(textOffset);
  }

  /// 根据给定像素偏移量，获取最靠近该偏移量前的文本位置索引
  int? getPositionBefore(Offset pixOffset) {
    assert(_needMeasured);
    TextPosition textPosition = getTextPositionForOffset(pixOffset);
    return getOffsetBefore(textPosition.offset);
  }

  /// 根据给定像素偏移量，获取最靠近该偏移量后的文本位置索引
  int? getPositionAfter(Offset pixOffset) {
    assert(_needMeasured);
    TextPosition textPosition = getTextPositionForOffset(pixOffset);
    return getOffsetAfter(textPosition.offset);
  }
}
