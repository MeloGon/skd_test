import 'package:ekd_test/core/error/failure.dart';
import 'package:ekd_test/core/usecases/usecase.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:ekd_test/features/home/domain/repositories/article_repository.dart';
import 'package:fpdart/src/either.dart';

class GetArticlesUsecase implements UseCase<List<Article>, NoParams> {
  final ArticleRepository articleRepository;
  GetArticlesUsecase(this.articleRepository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async =>
      await articleRepository.getNews();
}
