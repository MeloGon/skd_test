import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ekd_test/features/home/data/datasources/article_local_datasource.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';

@GenerateMocks([Box])
import 'article_local_datasource_test.mocks.dart';

void main() {
  late MockBox<ArticleModel> mockBox;
  late ArticleLocalDataSourceImpl localDataSource;

  final List<ArticleModel> mockArticles = <ArticleModel>[
    ArticleModel(
      author: 'Alguien',
      storyTitle: 'Titulo',
      createdAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockBox = MockBox<ArticleModel>();
    localDataSource = ArticleLocalDataSourceImpl(mockBox);
  });

  group('cacheArticles', () {
    test('should save articles in cache (box of hive)', () async {
      when(mockBox.clear()).thenAnswer((_) async => 0);
      when(mockBox.addAll(any)).thenAnswer((_) async => [0]);
      await localDataSource.cacheArticles(mockArticles);
      verify(mockBox.clear()).called(1);
      verify(mockBox.addAll(mockArticles)).called(1);
    });
  });

  group('getCachedArticles', () {
    test('should return articles from cache or box', () async {
      when(mockBox.values).thenReturn(mockArticles);
      final result = await localDataSource.getCachedArticles();

      expect(result, mockArticles);
      verify(mockBox.values).called(1);
    });

    test('should return empty list if there isnt data', () async {
      when(mockBox.values).thenReturn([]);
      final result = await localDataSource.getCachedArticles();
      expect(result, isEmpty);
      verify(mockBox.values).called(1);
    });
  });
}
