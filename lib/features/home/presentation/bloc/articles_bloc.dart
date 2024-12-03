import 'package:bloc/bloc.dart';
import 'package:ekd_test/core/di/service_locator.dart';
import 'package:ekd_test/core/usecases/usecase.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:equatable/equatable.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitialState()) {
    on<GetArticlesEvent>(_getArticlesHandler);
    on<RefreshArticlesEvent>(_refreshArticlesHandler);
  }

  void getArticles() {
    add(GetArticlesEvent());
  }

  void refreshArticles() {
    add(RefreshArticlesEvent());
  }

  void _getArticlesHandler(
      GetArticlesEvent event, Emitter<ArticlesState> emit) async {
    emit(ArticlesLoadingState());
    final articles = await getIt<GetArticlesUsecase>().call(NoParams());
    articles.fold(
        (failure) => emit(ArticlesErrorState(message: failure.message)),
        (articlesList) => emit(ArticlesLoadedState(articles: articlesList)));
  }

  void _refreshArticlesHandler(
      RefreshArticlesEvent event, Emitter<ArticlesState> emit) async {
    if (state is! ArticlesLoadedState) {
      emit(ArticlesLoadingState());
    }

    final articles = await getIt<GetArticlesUsecase>().call(NoParams());
    articles.fold(
        (failure) => emit(ArticlesErrorState(message: failure.message)),
        (articlesList) => emit(ArticlesLoadedState(articles: articlesList)));
  }
}
