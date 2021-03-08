import 'package:example/common/common_page.dart';
import 'package:flutter/material.dart';
import 'package:laohu_kit/components/expandable_text.dart';

class DemoExpandableText extends StatelessWidget {
  static const String _text = '英超联赛第27轮由曼城主场对阵曼联。上半场比赛，马夏尔开场35秒造点，B费主罚命中。斯特林在禁区内的倒地裁判并未理会，半场战罢，曼城主场0-1落后于曼联。下半场比赛开场，曼联经过3次传递后卢克-肖得分扩大领先优势，热苏斯屡屡错失良机。最终全场战罢，曼联客场2-0战胜曼城，终结了对手的21连胜。';

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.bodyText2;
    return CommonPage.builder(
      title: '展开收起',
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ExpandableText(text: _text, style: style, linkColor: Colors.blue, maxLines: 2),
            SizedBox(height: 30),
            ExpandableText(text: _text, style: style, linkColor: Colors.blue, maxLines: 4, iconSize: 0),
            SizedBox(height: 30),
            ExpandableText(text: _text, style: style, maxLines: 10),
          ],
        ),
      ),
    );
  }
}
