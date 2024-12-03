import 'package:ekd_test/core/router/app_router.dart';
import 'package:ekd_test/core/theme/app_theme.dart';
import 'package:ekd_test/core/theme/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final darkMode = ref.watch(darkModeProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'skd_app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkMode: darkMode).getTheme(),
    );
  }
}
