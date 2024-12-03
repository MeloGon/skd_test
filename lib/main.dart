import 'package:ekd_test/core/di/service_locator.dart';
import 'package:ekd_test/core/router/app_router.dart';
import 'package:ekd_test/features/home/data/models/article_model.dart';
import 'package:ekd_test/features/home/presentation/bloc/articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('articlesBox');
  serviceLocatorInit();
  runApp(const BlocProviders());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => getIt<RouterCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<ArticlesBloc>(),
      )
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouterCubit = context.watch<RouterCubit>().state;
    return MaterialApp.router(
      routerConfig: appRouterCubit,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
