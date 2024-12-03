import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:ekd_test/features/home/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({super.hits});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        hits: json["hits"] == null
            ? []
            : List<ArticleModel>.from(
                json["hits"]!.map((x) => ArticleModel.fromJson(x))),
      );
}
