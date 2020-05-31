import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'viewmodel/reader_viewmodel.dart';
import 'common/reader_config.dart';

class PageWidget extends StatelessWidget {
  final PageModel page;
  final TextStyle titleStyle;

  PageWidget({this.page, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ReaderConfig.instance.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            page.article.article.getTitle(),
            style: titleStyle ?? TextStyle(fontSize: ReaderConfig.instance.titleFontSize, color: Colors.black45)
          ),
          SizedBox(height: ReaderConfig.instance.titleMargin),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: page.article.getPageText(page.index),
                style: TextStyle(fontSize: ReaderConfig.instance.fontSize)
              )
            ]),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
