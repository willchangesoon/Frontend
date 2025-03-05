import 'package:es3_seller/provider/router_provider.dart';
import 'package:es3_seller/screen/s_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child:  App(),
    ),
  );
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
        colorSchemeSeed: Colors.white,
      ),
      routerConfig: router,
    );
  }
}
