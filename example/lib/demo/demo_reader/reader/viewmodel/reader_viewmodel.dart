import 'dart:async';
import 'dart:collection';

import 'package:laohu_kit/business/page_state/data_state.dart';
import 'package:laohu_kit/collection/stack.dart';

import '../factory/factorys.dart';
import '../common/reader_config.dart';
import '../common/reader_page_agent.dart';

class PageModel {
  final CacheArticle article;
  final int index;

  PageModel({required this.article, required this.index});
}

class CacheArticle {
  final IArticle article;
  final List<Map<String, int>> pages;
  final bool isFirst;

  CacheArticle({required this.article, required this.pages, this.isFirst = false});

  int get pageCount => pages.length;

  String getPageText(int pageIndex) {
    var start = pages[pageIndex][ReaderConfig.offsetStart];
    var end = pages[pageIndex][ReaderConfig.offsetEnd];
    return article.getContent().substring(start ?? 0, end);
  }
}

class ReaderViewModel {
  StreamController<DataState> _articleStream = StreamController();
  Stream<DataState> get articleStream => _articleStream.stream;

  final ArticleFactory factory;
  final int previousCacheSize;
  final int nextCacheSize;

  final Stack<CacheArticle> _previous = Stack<CacheArticle>();
  late CacheArticle _current;
  final ListQueue<CacheArticle> _next;
  
  int get previousPageCount {
    int count = 0;
    _previous.forEach((element) { count += element.pageCount; });
    return count;
  }

  int get currentPageCount => _current.pageCount ?? 0;
  
  int get _totalPageCount {
    int count = previousPageCount + _current.pageCount;
    _next.forEach((element) { count += element.pageCount; });
    return count;
  }

  ReaderViewModel({required this.factory, required this.previousCacheSize, required this.nextCacheSize})
      : _next = ListQueue<CacheArticle>(nextCacheSize);

  void notifyPageCount() {
    _articleStream.add(SuccessState(model: _totalPageCount + 1));
  }

  void fetchArticle() async {
    _articleStream.add(LoadingState());
    try {
      var article = await factory.fetchNextArticle(null);
      var pages = ReaderPageAgent.instance.getPageOffsets(article);
      _current = CacheArticle(article: article, pages: pages, isFirst: true);
      notifyPageCount();
      _fetchNextCacheArticle(article);
    } catch(e) {
      _articleStream.add(ErrorState(message: e.toString()));
    }
  }

  void _fetchNextCacheArticle(IArticle preArticle) async {
    if (_next.length >= nextCacheSize) {
      return;
    }
    late IArticle article;
    try {
      article = await factory.fetchNextArticle(preArticle);
      var pages = ReaderPageAgent.instance.getPageOffsets(article);
      _next.add(CacheArticle(article: article, pages: pages));
      notifyPageCount();
    } catch(e) {
      // nothing to do
    }
    _fetchNextCacheArticle(article);
  }
  
  PageModel getPage(int index) {
    print('get page: $index');
    int currentIndex = index - previousPageCount;
    if (currentIndex >= _current.pageCount) {
      return PageModel(article: _next.first, index: 0);
    } else if (currentIndex < 0) {
      var pre = _previous.peek();
      return PageModel(article: pre, index: pre.pageCount - 1);
    }
    return PageModel(article: _current, index: currentIndex);
  }

  void resetCurrentArticleByNext() {
    if (_next.isNotEmpty) {
      if (_previous.size >= previousCacheSize && previousCacheSize > 0) {
        _previous.removeAt(0);
      }
      var pre = _current;
      _previous.push(pre);
      _current = _next.removeFirst();
      notifyPageCount();
    }
    if (_next.isEmpty) {
      _fetchNextCacheArticle(_current.article);
    } else {
      _fetchNextCacheArticle(_next.last.article);
    }
  }

  void resetCurrentArticleByPrevious() {
    if (!_previous.isEmpty) {
      var next = _current;
      _next.addFirst(next);
      _current = _previous.pop();
    }
  }
  
  void dispose() {
    _articleStream.close();
  }
}