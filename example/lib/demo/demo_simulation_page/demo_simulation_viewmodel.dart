
import 'dart:convert';

import 'package:example/demo/demo_reader/model/article.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class SimulationViewModel {

  SimulationViewModel();

  void fetchArticle(Size size) async {
    String content = await rootBundle.loadString('assets/articles/article_1000.json');
    var response = json.decode(content);
    var article = Article.fromJson(response);
  }

  void dispose() {}
}