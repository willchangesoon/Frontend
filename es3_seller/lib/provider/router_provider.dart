import 'package:es3_seller/user/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final provider = ref.watch(userProvider);
  return GoRouter(
    routes: provider.routes,
    initialLocation: '/',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
