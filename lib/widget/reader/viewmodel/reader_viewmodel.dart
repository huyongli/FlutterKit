import 'dart:async';

import '../factory/factorys.dart';
import '../common/reader_config.dart';
import '../common/reader_page_agent.dart';
import '../../page_state/page_state.dart';

class ReaderViewModel {
  StreamController<PageState> _articleStream = StreamController();
  Stream<PageState> get articleStream => _articleStream.stream;

  final ArticleFactory factory;
  final int previousCacheSize;
  final int nextCacheSize;

  IArticle _previousArticle;
  IArticle _currentArticle;
  IArticle _nextArticle;

  List<Map<String, int>> _pages;

  int get pageCount => _pages?.length ?? 0;

  ReaderViewModel({this.factory, this.previousCacheSize, this.nextCacheSize});

  void fetchCurrentArticle() async {
    _articleStream.add(LoadingState());
    _currentArticle = await factory.fetchFirstArticle();
    _pages = ReaderPageAgent.instance.getPageOffsets(_currentArticle.getContent());
    _articleStream.add(SuccessState(model: _currentArticle));
  }

  void fetchNextArticle() async {
    _nextArticle = await factory.fetchNextArticle(_currentArticle);
  }

  String getPageText(int index) {
    var start = _pages[index][ReaderConfig.offsetStart];
    var end = _pages[index][ReaderConfig.offsetEnd];
    return _currentArticle.getContent().substring(start, end);
  }

  void dispose() {
    _articleStream.close();
  }
}