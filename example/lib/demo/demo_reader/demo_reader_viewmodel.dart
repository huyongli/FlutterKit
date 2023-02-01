import 'dart:convert' show json;

import 'package:example/demo/demo_reader/model/article.dart';
import 'package:flutter/services.dart';

import 'reader/factory/factorys.dart';

class ReaderFactory extends ArticleFactory {

  ReaderFactory();

  @override
  Future<IArticle> fetchNextArticle(IArticle? currentArticle) async {
    int id;
    if (currentArticle == null) {
      id = 1000;
    } else {
      id = (currentArticle as Article).nextId;
    }
    String content = await rootBundle.loadString('assets/articles/article_$id.json');
    var response = json.decode(content);
    return Article.fromJson(response);
  }

  @override
  Future<IArticle> fetchPreviousArticle(IArticle currentArticle) async {
    int preId = (currentArticle as Article).nextId;
    int id = preId == 0 ? 1006 : preId;
    String content = await rootBundle.loadString('assets/articles/article_$id.json');
    var response = json.decode(content);
    return Article.fromJson(response);
  }
}