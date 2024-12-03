import 'package:animate_do/animate_do.dart';
import 'package:ekd_test/core/shared/extensions/extensions.dart';
import 'package:ekd_test/features/home/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleWidget extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;
  final Article article;
  const ArticleWidget(
      {super.key,
      required this.icon,
      required this.color1,
      required this.color2,
      required this.article});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(4, 6),
                      blurRadius: 10),
                ],
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: <Color>[
                  color1,
                  color2,
                ])),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(icon,
                          size: 150, color: Colors.white.withOpacity(0.2)))
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 140, width: 40),
              20.w,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.storyTitle ?? '',
                      style: context.bodyMedium?.copyWith(color: Colors.white)),
                  10.h,
                  Text(
                    article.author ?? '',
                    style: context.bodySmall?.copyWith(color: Colors.white),
                  )
                ],
              )),
              if (article.createdAt != null)
                Text(DateFormat('H:m').format(article.createdAt!),
                    style: context.bodyMedium?.copyWith(color: Colors.white)),
              40.w
            ],
          )
        ],
      ),
    );
  }
}
