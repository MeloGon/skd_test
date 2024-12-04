import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'article_remote_datasource_test.mocks.dart';

@GenerateMocks(<Type>[ArticleRemoteDatasource])
void main() {
  late MockArticleRemoteDatasource mockArticleRemoteDatasource;

  final List<ArticleModel> mockArticles = <ArticleModel>[
    ArticleModel(
      author: 'Alguien',
      storyTitle: 'Titulo',
      createdAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockArticleRemoteDatasource = MockArticleRemoteDatasource();
  });

  test('fetch all articles from API', () async {
    when(mockArticleRemoteDatasource.getArticles())
        .thenAnswer((_) async => mockArticles);

    final result = await mockArticleRemoteDatasource.getArticles();

    expect(result, isNotNull);
    expect(result, isA<List<ArticleModel>>());
    expect(result.length, 1);
    expect(result[0].author, 'Alguien');
  });
}
