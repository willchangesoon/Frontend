import 'package:es3_seller/screen/s_home.dart';
import 'package:es3_seller/screen/s_login.dart';
import 'package:es3_seller/screen/s_sign_up.dart';
import 'package:es3_seller/screen/s_sign_up_finish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) => router);

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen()
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/sign-up-finish',
      builder: (context, state) => SignUpFinishScreen()
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen()
    )
  ]
);
