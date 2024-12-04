import 'package:bloc_test/bloc_test.dart';
import 'package:ekd_test/core/error/failure.dart';
import 'package:ekd_test/core/usecases/usecase.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:ekd_test/features/home/presentation/bloc/articles_bloc.dart';

@GenerateMocks([GetArticlesUsecase])
import 'articles_bloc_test.mocks.dart';

//Todo: check this tests something is happening damn
void main() {
  late MockGetArticlesUsecase mockGetArticlesUsecase;
  late ArticlesBloc articlesBloc;
  final List<ArticleModel> mockArticles = <ArticleModel>[
    ArticleModel(
      author: 'Alguien',
      storyTitle: 'Titulo',
      createdAt: DateTime.now(),
    ),
  ];
  provideDummy<Either<Failure, List<Article>>>(Right(mockArticles));

  setUp(() {
    mockGetArticlesUsecase = MockGetArticlesUsecase();
    articlesBloc = ArticlesBloc();
  });

  tearDown(() {
    articlesBloc.close();
  });

  group('ArticlesBloc', () {
    blocTest<ArticlesBloc, ArticlesState>(
      'emits [ArticlesLoadingState, ArticlesLoadedState] when GetArticlesEvent runs correctly',
      build: () {
        when(mockGetArticlesUsecase.call(NoParams()))
            .thenAnswer((_) async => Right(mockArticles));
        return articlesBloc;
      },
      act: (bloc) => bloc.add(GetArticlesEvent()),
      expect: () => [
        ArticlesLoadingState(),
        ArticlesLoadedState(articles: mockArticles),
      ],
    );

    blocTest<ArticlesBloc, ArticlesState>(
      'emits [ArticlesLoading, ArticlesError] when FetchArticlesEvent failed',
      build: () {
        when(mockGetArticlesUsecase(NoParams())).thenAnswer(
          (_) async => Left(ServerFailure('ups')),
        );
        return articlesBloc;
      },
      act: (bloc) => bloc.add(GetArticlesEvent()),
      expect: () => [
        ArticlesLoadingState(),
        const ArticlesErrorState(message: 'ups'),
      ],
    );
  });
}
