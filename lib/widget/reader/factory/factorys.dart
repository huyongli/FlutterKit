abstract class IChapter {

}

abstract class IArticle {
  String getTitle();
  String getContent();
}

abstract class ArticleFactory {
  Future<IArticle> fetchFirstArticle();

  Future<IArticle> fetchNextArticle(IArticle currentArticle);
}