import 'package:ekd_test/core/shared/extensions/text_extension.dart';
import 'package:ekd_test/core/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 's',
        titleStyle: context.headlineLarge,
      ),
    );
  }
}
