import 'package:ekd_test/core/shared/extensions/text_extension.dart';
import 'package:ekd_test/core/shared/widgets/custom_appbar.dart';
import 'package:ekd_test/core/utils/app_strings.dart';
import 'package:ekd_test/features/home/presentation/bloc/articles_bloc.dart';
import 'package:ekd_test/features/home/presentation/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: AppStrings.articles,
        titleStyle: context.headlineMedium,
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoadingState) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        child: ListTile(
                          title: Text(AppStrings.testText),
                          subtitle: Text(AppStrings.testText2),
                          trailing: Text(AppStrings.testText3),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ArticlesLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ArticlesBloc>().refreshArticles();
              },
              child: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
                  return ArticleWidget(
                    icon: Icons.file_copy,
                    color1: const Color(0xff00325f),
                    color2: const Color(0xff0073b9),
                    article: article,
                  );
                },
              ),
            );
          } else if (state is ArticlesErrorState) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
