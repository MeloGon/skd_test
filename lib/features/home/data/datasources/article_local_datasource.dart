import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<List<ArticleModel>> getCachedArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final Box<ArticleModel> _box;

  ArticleLocalDataSourceImpl(this._box);

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    await _box.clear();
    await _box.addAll(articles);
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    return _box.values.toList();
  }
}
