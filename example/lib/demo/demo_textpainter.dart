import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/util/text_measure_util.dart';

class DemoTextPainter extends StatelessWidget {
  final String text = '7月1日国务院新闻办举行的新闻发布会上';
  final double height = 40;
  final double width = 100;
  final double space = 10;

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.bodyText1;
    var span = TextSpan(text: text, style: textStyle);
    int maxLines = 2;
    TextMeasurer measure = TextMeasurer(text: span, maxLines: maxLines, maxWidth: width);
    measure.measure();
    Offset offset = Offset(measure.textRect.width, measure.textRect.height);
    return CommonPage.builder(
      title: 'Demo TextPainter',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              color: Colors.blueAccent,
              child: Text(text, style: textStyle),
              margin: EdgeInsets.only(bottom: space),
            ),
            Container(
              width: width,
              height: height,
              color: Colors.blueAccent,
              child: Text(text, style: textStyle),
              margin: EdgeInsets.only(bottom: space),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.blueAccent,
              child: Text(
                '限制文本最大显示行数：$maxLines\n\n'
                '文本实际需要展示行数：${measure.lines}\n'
                '测量文本行高：${measure.lineHeight}\n'
                '全部展示完整所需高度：${measure.allLayoutHeight}\n'
                '是否超出最大展示行数: ${measure.didExceedMaxLines}\n\n'
                '当前展示文本范围索引: ${measure.getTextPositionForOffset(offset)}\n\n'
                '显示的最后一行的索引范围: ${measure.getLineBoundary(TextPosition(offset: measure.getTextPositionForOffset(offset).offset))}\n\n'
                'getOffsetBefore: ${measure.getOffsetBefore(measure.getTextPositionForOffset(offset).offset)}\n'
                'getOffsetAfter: ${measure.getOffsetAfter(measure.getTextPositionForOffset(offset).offset)}\n\n'
                'getPositionBefore: ${measure.getPositionBefore(offset)}\n'
                'getPositionAfter: ${measure.getPositionAfter(offset)}\n\n'
                '当前限制条件下展示所需的尺寸：${measure.textRect}\n',
                style: textStyle,
              ),
              margin: EdgeInsets.only(bottom: space, left: 20, right: 20),
            ),
          ],
        ),
      ),
    );
  }
}
