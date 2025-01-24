import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/common/screen/s_category.dart';
import 'package:es3_frontend/common/screen/s_event.dart';
import 'package:es3_frontend/common/screen/s_favorite.dart';
import 'package:es3_frontend/common/screen/s_home.dart';
import 'package:es3_frontend/common/screen/s_mypage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return router;
});


final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return DefaultLayout(
          child: child, // Injects the current child screen
        );
      },
      routes: [
        GoRoute(
          path: '/category',
          builder: (context, state) => CategoryScreen(),
        ),
        GoRoute(
          path: '/event',
          builder: (context, state) => EventScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/favorite',
          builder: (context, state) => FavoriteScreen(),
        ),
        GoRoute(
          path: '/mypage',
          builder: (context, state) => MyPageScreen(),
        ),
      ],
    ),
  ],
);