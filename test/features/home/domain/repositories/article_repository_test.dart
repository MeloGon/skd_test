import 'package:ekd_test/core/network/app_network.dart';
import 'package:ekd_test/features/home/data/datasources/article_local_datasource.dart';
import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/data/repositories/article_repository_impl.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

import 'article_repository_test.mocks.dart';

@GenerateMocks([ArticleRemoteDatasource, ArticleLocalDataSource, AppNetwork])
void main() {
  late MockArticleRemoteDatasource mockRemoteDataSource;
  late MockArticleLocalDataSource mockLocalDataSource;
  late MockAppNetwork mockAppNetwork;
  late ArticleRepositoryImpl repository;

  final List<ArticleModel> mockArticles = <ArticleModel>[
    ArticleModel(
      author: 'Alguien',
      storyTitle: 'Titulo',
      createdAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockRemoteDataSource = MockArticleRemoteDatasource();
    mockLocalDataSource = MockArticleLocalDataSource();
    mockAppNetwork = MockAppNetwork();
    repository = ArticleRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockAppNetwork,
    );
  });

  group('getNews', () {
    test(
        'should return articles from remoteDataSource and caching if there is internet connection',
        () async {
      when(mockAppNetwork.checkInternetConnection())
          .thenAnswer((_) async => true);

      when(mockRemoteDataSource.getArticles())
          .thenAnswer((_) async => mockArticles);

      when(mockLocalDataSource.cacheArticles(mockArticles))
          .thenAnswer((_) async => Future.value());

      final result = await repository.getNews();

      expect(result, Right(mockArticles));

      verify(mockAppNetwork.checkInternetConnection()).called(1);
      verify(mockRemoteDataSource.getArticles()).called(1);
      verify(mockLocalDataSource.cacheArticles(mockArticles)).called(1);
      verifyNever(mockLocalDataSource.getCachedArticles());
    });

    test(
        'should return artciles from localDataSource if there is not internet connection',
        () async {
      when(mockAppNetwork.checkInternetConnection())
          .thenAnswer((_) async => false);

      when(mockLocalDataSource.getCachedArticles())
          .thenAnswer((_) async => mockArticles);

      final result = await repository.getNews();

      expect(result, Right(mockArticles));

      verify(mockAppNetwork.checkInternetConnection()).called(1);
      verify(mockLocalDataSource.getCachedArticles()).called(1);
      verifyNever(mockRemoteDataSource.getArticles());
    });
  });
}
