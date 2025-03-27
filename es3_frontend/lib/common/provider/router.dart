import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/common/screen/s_category.dart';
import 'package:es3_frontend/common/screen/s_event.dart';
import 'package:es3_frontend/common/screen/s_favorite.dart';
import 'package:es3_frontend/common/screen/s_home.dart';
import 'package:es3_frontend/common/screen/s_login.dart';
import 'package:es3_frontend/common/screen/s_mypage.dart';
import 'package:es3_frontend/products/screen/s_product_detail.dart';
import 'package:es3_frontend/common/screen/s_sign_up.dart';
import 'package:es3_frontend/common/screen/s_update_profile.dart';
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
        final String currentPath = state.uri.toString();

        final Map<String, Map<String, dynamic>> routeSettings = {
          '/mypage/setting': {'title': 'Setting', 'showAppBarBtnBack': true},
          '/mypage/setting/update-profile': {'title': 'Update Profile', 'showAppBarBtnBack': true},
          '/mypage/manage-address': {'title': 'Manage Address', 'showAppBarBtnBack': true},
        };

        final showAppBarBtnBack = routeSettings[currentPath]?['showAppBarBtnBack'] ?? false;
        final title = routeSettings[currentPath]?['title'];

        return DefaultLayout(
          showAppBarBtnBack: showAppBarBtnBack,
          title: title,
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
              routes: [
                GoRoute(
                  path: 'update-profile',
                  builder: (context, state) => UpdateProfileScreen(),
                ),
              ]
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/product-detail/:pid',
      name: ProductDetailScreen.routeName,
      builder: (context, state) => ProductDetailScreen(id: int.parse(state.pathParameters['pid']!)),
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
