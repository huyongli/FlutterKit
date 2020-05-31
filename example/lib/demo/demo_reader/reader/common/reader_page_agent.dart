import 'package:example/demo/demo_reader/reader/factory/factorys.dart';
import 'package:flutter/material.dart';

import 'reader_config.dart';

class ReaderPageAgent {
  ReaderPageAgent._internal();
  
  static ReaderPageAgent _instance = new ReaderPageAgent._internal();
  
  static ReaderPageAgent get instance => _instance;

  double get pageWidth => ReaderConfig.instance.contentWidth;
  double get pageHeight => ReaderConfig.instance.contentHeight - titleHeight ?? pageTitleSize;
  double get pageFontSize => ReaderConfig.instance.fontSize;
  double get pageTitleSize => ReaderConfig.instance.titleFontSize;

  int maxLines;
  double titleHeight;

  List<Map<String, int>> getPageOffsets(IArticle article) {
    String content = article.getContent();

    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

    _tryMeasureTitleHeight(article.getTitle(), textPainter);

    _measurePageMaxLinesIfNeed(content, textPainter);

    String tmp = content;
    List<Map<String, int>> pages = [];
    int last = 0;
    while (true) {
      var end = _getPageOffset(tmp, textPainter, maxLines);
      if (end == 0) {
        break;
      }
      tmp = tmp.substring(end, tmp.length);

      Map<String, int> offset = {};
      offset[ReaderConfig.offsetStart] = last;
      offset[ReaderConfig.offsetEnd] = last + end;
      last = last + end;
      pages.add(offset);
    }
    return pages;
  }

  void _layout(String text, TextPainter textPainter) {
    textPainter.text = TextSpan(text: text, style: TextStyle(fontSize: pageFontSize));
    textPainter.layout(maxWidth: pageWidth);
  }

  void _measurePageMaxLinesIfNeed(String text, TextPainter textPainter) {
    _layout(text.substring(0, 20), textPainter);
    var lines = textPainter.computeLineMetrics();
    maxLines = (pageHeight / lines[0].height).floor();
  }
  
  int _getPageOffset(String text, TextPainter textPainter, int maxLines) {
    _layout(text, textPainter);
    int offset = textPainter.getPositionForOffset(Offset(pageWidth, pageHeight)).offset;
    if (textPainter.computeLineMetrics().length <= maxLines) {
      return offset;
    }
    String tmp = text.substring(0, offset);
    _layout(tmp, textPainter);
    if (textPainter.computeLineMetrics().length <= maxLines) {
      return offset;
    }
    TextRange range = textPainter.getLineBoundary(TextPosition(offset: offset));
    if (range.start >= range.end) {
      return offset;
    }
    String nextText = tmp.substring(0, range.start);
    return _getPageOffset(nextText, textPainter, maxLines);
  }

  void _tryMeasureTitleHeight(String title, TextPainter textPainter) {
    if (titleHeight != null) {
      return;
    }
    textPainter.text = TextSpan(text: title, style: TextStyle(fontSize: pageTitleSize));
    textPainter.layout(maxWidth: pageWidth);
    var lines = textPainter.computeLineMetrics();
    titleHeight = lines != null && lines.isNotEmpty ? lines[0].height : pageTitleSize;
  }
}