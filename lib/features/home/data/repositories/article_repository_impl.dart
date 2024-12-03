import 'package:ekd_test/core/error/failure.dart';
import 'package:ekd_test/features/home/data/datasources/article_remote_datasource.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/entities/news.dart';
import 'package:ekd_test/features/home/domain/repositories/article_repository.dart';
import 'package:fpdart/src/either.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource remoteDataSource;

  ArticleRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<Article>>> getNews() async {
    try {
      final articles = await remoteDataSource.getArticles();
      return Right(articles);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
