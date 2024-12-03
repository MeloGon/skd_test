import 'package:ekd_test/core/error/failure.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/entities/news.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ArticleRepository {
  Future<Either<Failure, List<Article>>> getNews();
}
