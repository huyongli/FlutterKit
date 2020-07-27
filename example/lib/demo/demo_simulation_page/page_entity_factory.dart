import 'dart:ui';

import 'package:example/demo/demo_reader/reader/factory/factorys.dart';
import 'package:example/demo/demo_simulation_page/page_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _fontSize = 16;
const Color _fontColor = Colors.black;

class PageContentFactory {
  static List<String> getPageContents(IArticle article, Size size) {
    String content = article.getContent();

    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

    int maxLines = _measurePageMaxLinesIfNeed(content, textPainter, size);

    String tmp = content;
    List<String> pages = [];
    int last = 0;
    while (true) {
      var end = _getPageOffset(tmp, textPainter, maxLines, size);
      if (end == 0) {
        break;
      }
      tmp = tmp.substring(end, tmp.length);
      pages.add(content.substring(last, last + end));
      last = last + end;
    }
    return pages;
  }

  static int _measurePageMaxLinesIfNeed(String text, TextPainter textPainter, Size size) {
    _layout(text.substring(0, 20), textPainter, size);
    var lines = textPainter.computeLineMetrics();
    return (size.height / lines[0].height).floor();
  }

  static void _layout(String text, TextPainter textPainter, Size size) {
    textPainter.text = TextSpan(text: text, style: TextStyle(fontSize: _fontSize, color: _fontColor));
    textPainter.layout(maxWidth: size.width);
  }

  static int _getPageOffset(String text, TextPainter textPainter, int maxLines, Size size) {
    _layout(text, textPainter, size);
    int offset = textPainter.getPositionForOffset(Offset(size.width, size.height)).offset;
    if (textPainter.computeLineMetrics().length <= maxLines) {
      return offset;
    }
    String tmp = text.substring(0, offset);
    _layout(tmp, textPainter, size);
    if (textPainter.computeLineMetrics().length <= maxLines) {
      return offset;
    }
    TextRange range = textPainter.getLineBoundary(TextPosition(offset: offset));
    if (range.start >= range.end) {
      return offset;
    }
    String nextText = tmp.substring(0, range.start);
    return _getPageOffset(nextText, textPainter, maxLines, size);
  }
}

class PageCanvasEntityFactory {
  static List<PageCanvasEntity> create(List<String> contents, Size size) {
    return contents.map((e) => from(e, size)).toList();
  }

  static PageCanvasEntity from(String content, Size size) {
    PictureRecorder pictureRecorder = PictureRecorder();
    Canvas pageCanvas = Canvas(pictureRecorder);
    pageCanvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = Colors.green,
    );
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: content,
          style: TextStyle(color: _fontColor, fontSize: _fontSize),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start);
    textPainter.layout(maxWidth: size.width);
    textPainter.paint(pageCanvas, Offset(0, 0));
    return PageCanvasEntity(picture: pictureRecorder.endRecording());
  }
}
