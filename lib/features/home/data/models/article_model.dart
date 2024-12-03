import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends Article {
  @HiveField(0)
  final String? author;

  @HiveField(1)
  final DateTime? createdAt;

  @HiveField(2)
  final String? storyTitle;

  ArticleModel({this.author, this.createdAt, this.storyTitle})
      : super(author: author, createdAt: createdAt, storyTitle: storyTitle);

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
