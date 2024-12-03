import 'package:ekd_test/features/home/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({super.author, super.createdAt, super.storyTitle});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        author: json["author"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        storyTitle: json["story_title"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "created_at": createdAt?.toIso8601String(),
        "story_title": storyTitle,
      };
}
