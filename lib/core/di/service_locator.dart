import 'package:ekd_test/core/network/app_network.dart';
import 'package:ekd_test/core/router/app_router.dart';
import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/data/repositories/article_repository_impl.dart';
import 'package:ekd_test/features/home/domain/repositories/article_repository.dart';
import 'package:ekd_test/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:ekd_test/features/home/presentation/bloc/articles_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(AppNetwork());
  //articles
  getIt.registerLazySingleton<ArticleRemoteDatasource>(
      () => ArticleRemoteDatasourceImpl(getIt()));
  getIt.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(getIt()));
  getIt.registerLazySingleton<GetArticlesUsecase>(
      () => GetArticlesUsecase(getIt()));
  getIt.registerSingleton(ArticlesBloc()..getArticles());
}
