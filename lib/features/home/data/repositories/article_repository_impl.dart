import 'package:ekd_test/core/error/failure.dart';
import 'package:ekd_test/core/network/app_network.dart';
import 'package:ekd_test/features/home/data/datasources/article_local_datasource.dart';
import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/repositories/article_repository.dart';
import 'package:fpdart/src/either.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final AppNetwork appNetwork;

  ArticleRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.appNetwork);
  @override
  Future<Either<Failure, List<Article>>> getNews() async {
    try {
      if (await appNetwork.checkInternetConnection()) {
        final articles = await remoteDataSource.getArticles();
        await localDataSource.cacheArticles(articles);
        return Right(articles);
      } else {
        final cachedArticles = await localDataSource.getCachedArticles();
        if (cachedArticles.isNotEmpty) {
          return Right(cachedArticles);
        } else {
          return Left(CacheFailure("No cached data available"));
        }
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
