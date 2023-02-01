import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laohu_kit/business/page_state/page_state.dart';

import 'factory/factorys.dart';
import 'page_widget.dart';
import 'reader_provider.dart';
import 'viewmodel/reader_viewmodel.dart';
import 'common/reader_config.dart';

typedef ArticleFactoryBuilder = ArticleFactory Function();

class ReaderWidget extends StatefulWidget {

  ReaderWidget({
    super.key,
    required this.builder,
    this.previousCacheSize = 10000,
    this.nextCacheSize = 1,
    this.padding,
    required this.textStyle,
    this.titleStyle,
    required this.background,
    this.loadingWidget
  }): assert(previousCacheSize > 0),
      assert(nextCacheSize > 0);

  final Widget background;
  final ArticleFactoryBuilder builder;
  final int previousCacheSize;
  final int nextCacheSize;
  final EdgeInsetsGeometry? padding;
  final TextStyle textStyle;
  final TextStyle? titleStyle;
  final Widget? loadingWidget;

  @override
  _ReaderWidgetState createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  late ReaderViewModel _viewModel;
  PageController _pageController = PageController(keepPage: false);

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
      _viewModel.fetchArticle();
    });

    _pageController.addListener(this._onPageScroll);
  }

  void _updateConfig() {
    ReaderConfig.instance.fontSize = widget.textStyle.fontSize;
    ReaderConfig.instance.padding = widget.padding;
    ReaderConfig.instance.titleFontSize = widget.titleStyle?.fontSize;
  }

  void _onPageScroll() {
    var page = _pageController.offset / ReaderConfig.instance.screenWidth;

    var nextArticlePage = _viewModel.previousPageCount + _viewModel.currentPageCount;
    if (page >= nextArticlePage) {
      print('now is next article: $page');
      _viewModel.resetCurrentArticleByNext();
    }

    if (page <= _viewModel.previousPageCount - 1) {
      print('now is previous article: $page');
      _viewModel.resetCurrentArticleByPrevious();
    }
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
                child: StreamBuilder<PageState>(
                  stream: _viewModel.articleStream,
                  builder: (context, snap) {
                    PageState? state = snap.data;
                    if (state is! SuccessState) {
                      return Container();
                    }
                    int pageCount = (state as SuccessState).model;
                    return PageView.builder(
                      controller: _pageController,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == pageCount - 1) {
                          return widget.loadingWidget ?? Container(
                              alignment: Alignment.center,
                              child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator())
                          );
                        } else {
                          var page = _viewModel.getPage(index);
                          return PageWidget(page: page, titleStyle: widget.titleStyle);
                        }
                      },
                      itemCount: pageCount,
                    );
                  },
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
