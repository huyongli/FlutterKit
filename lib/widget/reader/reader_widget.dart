import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../page_state/page_state_widget_providing.dart';
import 'factory/factorys.dart';
import 'reader_provider.dart';
import 'viewmodel/reader_viewmodel.dart';
import 'common/reader_config.dart';

typedef ArticleFactoryBuilder = ArticleFactory Function();

class ReaderWidget extends StatefulWidget {

  ReaderWidget({
    Key key,
    @required this.builder,
    this.previousCacheSize = 1,
    this.nextCacheSize = 1,
    this.padding,
    this.textStyle,
    this.background
  }): assert(builder != null),
      assert(previousCacheSize > 0),
      assert(nextCacheSize > 0),
      super(key: key);

  final Widget background;
  final ArticleFactoryBuilder builder;
  final int previousCacheSize;
  final int nextCacheSize;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  @override
  _ReaderWidgetState createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> with PageStateWidgetProviding {
  ReaderViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _updateConfig();
    _viewModel = ReaderViewModel(
      factory: widget.builder(),
      previousCacheSize: widget.previousCacheSize,
      nextCacheSize: widget.nextCacheSize
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel.fetchCurrentArticle();
    });
  }

  void _updateConfig() {
    ReaderConfig.instance.fontSize = widget.textStyle?.fontSize;
    ReaderConfig.instance.padding = widget.padding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: ReaderProvider(
          viewModel: _viewModel,
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: widget.background ?? Container(color: Colors.white70)),
              Positioned.fill(
                child: buildPageStateStreamWidget(
                  stream: _viewModel.articleStream,
                  widgetBuilder: (state) {
                    return PageView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: ReaderConfig.instance.padding,
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: _viewModel.getPageText(index),
                                  style: TextStyle(fontSize: ReaderConfig.instance.fontSize)
                              )
                            ]),
                            textAlign: TextAlign.justify,
                          ),
                        );
                      },
                      itemCount: _viewModel.pageCount,
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
