import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/common/screen/s_category.dart';
import 'package:es3_frontend/common/screen/s_event.dart';
import 'package:es3_frontend/common/screen/s_favorite.dart';
import 'package:es3_frontend/common/screen/s_home.dart';
import 'package:es3_frontend/common/screen/s_login.dart';
import 'package:es3_frontend/common/screen/s_mypage.dart';
import 'package:es3_frontend/common/screen/s_sign_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screen/s_setting.dart';

final routerProvider = Provider((ref) {
  return router;
});

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final showAppBarBtnBack = state.uri.toString() == '/mypage/setting';
        return DefaultLayout(
          showAppBarBtnBack: showAppBarBtnBack,
          title: showAppBarBtnBack ? 'Setting' : null,
          child: child,
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
          routes: [
            GoRoute(
              path: 'setting',
              builder: (context, state) => SettingScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
  ],
);
