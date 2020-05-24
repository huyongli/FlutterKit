import 'dart:convert' show json;

import 'package:example/demo/demo_reader/model/article.dart';
import 'package:flutter/services.dart';
import 'package:laohu_kit/widget/reader/factory/factorys.dart';

class ReaderFactory extends ArticleFactory {

  ReaderFactory();

  @override
  Future<IArticle> fetchNextArticle(IArticle currentArticle) async {
    return await fetchFirstArticle();
  }

  @override
  Future<IArticle> fetchFirstArticle() async {
    String content = await rootBundle.loadString('assets/articles/article_1000.json');
    var response = json.decode(content);
    return Article.fromJson(response);
  }
}