import 'package:ekd_test/core/network/app_network.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
//import 'package:ekd_test/features/home/domain/entities/news.dart';

abstract interface class ArticleRemoteDatasource {
  Future<List<ArticleModel>> getArticles();
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final AppNetwork appNetwork;

  ArticleRemoteDatasourceImpl(this.appNetwork);

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final response = await appNetwork.get(
          url: 'http://hn.algolia.com/api/v1/search_by_date',
          parameters: {'query': 'mobile'});
      return (response['hits'] as List)
          .map((json) => ArticleModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Something wrong ...');
    }
  }
}
