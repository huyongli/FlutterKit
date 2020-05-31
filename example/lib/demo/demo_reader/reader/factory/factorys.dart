abstract class IChapter {

}

abstract class IArticle {
  String getTitle();
  String getContent();
  String getId();
}

abstract class ArticleFactory {

  /// is first fetch article when [currentArticle] is null
  Future<IArticle> fetchNextArticle(IArticle currentArticle);

  Future<IArticle> fetchPreviousArticle(IArticle currentArticle);
}