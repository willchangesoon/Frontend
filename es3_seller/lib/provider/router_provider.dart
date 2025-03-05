import 'package:es3_seller/screen/s_sign_up_finish.dart';
import 'package:es3_seller/screen/s_signup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) => router);

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/sign-up-finish',
      builder: (context, state) => SignUpFinishScreen()
    )
  ]
);