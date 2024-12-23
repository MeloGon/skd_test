import 'package:ekd_test/core/network/app_network.dart';
import 'package:ekd_test/core/router/app_router.dart';
import 'package:ekd_test/features/home/data/datasources/article_local_datasource.dart';
import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:ekd_test/features/home/data/repositories/article_repository_impl.dart';
import 'package:ekd_test/features/home/domain/repositories/article_repository.dart';
import 'package:ekd_test/features/home/domain/usecases/get_articles_usecase.dart';
import 'package:ekd_test/features/home/presentation/bloc/articles_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() async {
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(AppNetwork());
  //articles
  final articlesBox = await Hive.openBox<ArticleModel>("articlesBox");
  getIt.registerSingleton<Box<ArticleModel>>(articlesBox);
  getIt.registerLazySingleton<ArticleRemoteDatasource>(
      () => ArticleRemoteDatasourceImpl(getIt()));
  getIt.registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<GetArticlesUsecase>(
      () => GetArticlesUsecase(getIt()));
  getIt.registerSingleton(ArticlesBloc()..getArticles());
}
