import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laohu_kit/util/text_measure_util.dart';

class DemoTextPainter extends StatelessWidget {
  final String text =
      '7月1日国务院新闻办举行的新闻发布会上，国务院港澳事务办公室副主任张晓明表示：一法可安香江。香港国安法是继香港基本法之后，中央为香港特别行政区专门制定的第二部重要法律。他把香港国安法比喻为香港繁荣稳定的“守护神”和“定海神针”。';
  final double height = 100;
  final double width = 200;
  final double space = 10;

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.bodyText1;
    var constraint = TextMeasureConstraint(textFontSize: textStyle.fontSize, width: width, maxLines: 5);
    var result = TextMeasureUtil.measure(text, constraint);
    return CommonPage.builder(
        title: 'Demo TextPainter',
        child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              width: width,
              color: Colors.blueAccent,
              child: Text(text, style: textStyle),
              margin: EdgeInsets.only(bottom: space)),
          Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: width,
              color: Colors.blueAccent,
              child: Text(
                  '限制文本最大显示行数：5\n'
                  '文本实际行数：${result.lines}\n'
                  '测量行高：${result.lineHeight}\n'
                  '测量实际所需高度：${result.measureHeight}\n'
                  'exceedMaxLines: ${result.didExceedMaxLines}\n'
                  '当前展示文本范围索引: ${result.getPositionForOffset(Offset(result.painter.width, result.painter.height))}\n'
                  '显示的最后一行的索引范围: ${result.getLineBoundary(TextPosition(offset: result.getPositionForOffset(Offset(result.painter.width, result.painter.height))))}\n'
                  '测量当前尺寸：${result.painter.size}\n'
                  '测量当前宽度：${result.painter.width}\n'
                  '测量当前高度：${result.painter.height}',
                  style: textStyle),
              margin: EdgeInsets.only(bottom: space)),
          Container(width: width, height: height, color: Colors.blueAccent, child: Text(text, style: textStyle))
        ])));
  }
}
