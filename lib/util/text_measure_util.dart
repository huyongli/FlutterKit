import 'package:flutter/widgets.dart';

class TextMeasureResult {
  double lineHeight;
  int lines;
  TextPainter painter;
  bool didExceedMaxLines;

  TextMeasureResult({@required TextPainter painter, @required TextMeasureConstraint constraint}) {
    this.painter = painter;
    var lineMetrics = painter.computeLineMetrics();
    lineHeight = lineMetrics != null && lineMetrics.isNotEmpty ? lineMetrics[0].height : constraint.textFontSize;
    lines = lineMetrics?.length ?? 0;
    didExceedMaxLines = painter.didExceedMaxLines;
  }

  /// 当前测量限定条件下展示时所占用的高度
  double get height => painter.height;

  double get width => painter.width;

  /// 展示完所有文本所需要的实际高度
  double get measureHeight => (lineHeight ?? 0) * (lines ?? 0);

  /// 根据指定范围获取该范围内能显示的最大的文本索引
  int getPositionForOffset(Offset offset) {
    return painter.getPositionForOffset(offset).offset;
  }

  /// 根据显示的文本位置获取该位置所在行的索引范围
  TextRange getLineBoundary(TextPosition position) {
    return painter.getLineBoundary(position);
  }
}

class TextMeasureConstraint {
  double textFontSize;
  double textScaleFactor;
  TextDirection textDirection;
  double width;
  String ellipsis;
  int maxLines;

  TextMeasureConstraint(
      {@required this.textFontSize,
      @required this.width,
      this.maxLines,
      this.ellipsis,
      this.textScaleFactor = 1.0,
      this.textDirection = TextDirection.ltr})
      : assert(textFontSize != null),
        assert(width != null);
}

class TextMeasureUtil {
  static TextPainter _layoutText(String text, TextMeasureConstraint constraint) {
    TextPainter textPainter = TextPainter(
      textDirection: constraint.textDirection,
      textScaleFactor: constraint.textScaleFactor,
      maxLines: constraint.maxLines,
      ellipsis: constraint.ellipsis,
    );
    textPainter.text = TextSpan(text: text, style: TextStyle(fontSize: constraint.textFontSize));
    textPainter.layout(maxWidth: constraint.width);
    return textPainter;
  }

  static TextMeasureResult measure(String text, TextMeasureConstraint constraint) {
    TextPainter textPainter = _layoutText(text, constraint);
    return TextMeasureResult(painter: textPainter, constraint: constraint);
  }
}
