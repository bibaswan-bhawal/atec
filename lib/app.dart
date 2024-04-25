import 'package:flutter/material.dart';
import 'package:atec/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atec/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Close the keyboard when the app starts
    if (FocusScope.of(context).hasPrimaryFocus) FocusScope.of(context).unfocus();

    return MaterialApp.router(
      title: 'ATEC',
      routerConfig: router,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
