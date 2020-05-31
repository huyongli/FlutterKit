
import 'package:example/demo/demo_reader/reader/factory/factorys.dart';

class Article extends IArticle {
  int id;
  int nextId;
  int prevId;
  String title;
  String content;

  Article();

  factory Article.fromJson(Map<String, dynamic> json) {
    String content = json['content'];
    content = content.replaceAll('\n', '\n　　');
    return Article()
        ..id = json['id']
        ..nextId = json['next_id']
        ..prevId = json['prev_id']
        ..title = json['title']
        ..content = '　　$content';
  }

  @override
  String getTitle() => title;

  @override
  String getContent() => content;

  @override
  String getId() => id.toString();
}