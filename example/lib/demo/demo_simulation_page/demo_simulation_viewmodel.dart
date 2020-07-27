
import 'dart:async';
import 'dart:convert';

import 'package:example/demo/demo_reader/model/article.dart';
import 'package:example/demo/demo_simulation_page/page_entity.dart';
import 'package:example/demo/demo_simulation_page/page_entity_factory.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class SimulationViewModel {
  StreamController<List<PageCanvasEntity>> _controller = StreamController<List<PageCanvasEntity>>();
  Stream<List<PageCanvasEntity>> get contents => _controller.stream;

  SimulationViewModel();

  void fetchArticle(Size size) async {
    String content = await rootBundle.loadString('assets/articles/article_1000.json');
    var response = json.decode(content);
    Article article = Article.fromJson(response);
    var list = PageCanvasEntityFactory.create(PageContentFactory.getPageContents(article, size), size);
    _controller.add(list);
  }

  void dispose() {
    _controller.close();
  }
}