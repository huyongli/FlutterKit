import 'package:flutter/widgets.dart';

class TextMeasureResult {
  double lineHeight;
  int lines;

  TextMeasureResult({this.lineHeight, this.lines});

  double get height => (lineHeight ?? 0) * (lines ?? 0);
}

class TextMeasureConstraint {
  double fontSize;
  double width;
  TextDirection textDirection;

  TextMeasureConstraint({
    @required double textFontSize,
    @required this.width,
    double textScaleFactor = 1,
    this.textDirection = TextDirection.ltr
  })
    : assert(textFontSize != null),
      assert(width != null),
      fontSize = textFontSize * textScaleFactor;
}

class TextMeasureUtil {
  static TextPainter layoutText(String text, TextMeasureConstraint constraint) {
    TextPainter textPainter = TextPainter(textDirection: constraint.textDirection);
    textPainter.text = TextSpan(text: text, style: TextStyle(fontSize: constraint.fontSize));
    textPainter.layout(maxWidth: constraint.width);
    return textPainter;
  }

  static TextMeasureResult measure(String text, TextMeasureConstraint constraint) {
    TextPainter textPainter = layoutText(text, constraint);
    var lineMetrics = textPainter.computeLineMetrics();
    double lineHeight = lineMetrics != null && lineMetrics.isNotEmpty ? lineMetrics[0].height : constraint.fontSize;
    int lines = lineMetrics?.length ?? 0;
    return TextMeasureResult(lineHeight: lineHeight, lines: lines);
  }
}
