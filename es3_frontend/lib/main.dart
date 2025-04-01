import 'package:es3_frontend/common/const/colors.dart';
import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/common/provider/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'GmarketSans',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: MAIN_COLOR)
      ),
      // home: DefaultLayout(),
      routerConfig: router,
    );
  }
}

