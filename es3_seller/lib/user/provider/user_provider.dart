import 'dart:async';

import 'package:es3_seller/user/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screen/s_home.dart';
import '../../screen/s_login.dart';
import '../../screen/s_sign_up.dart';
import '../../screen/s_sign_up_finish.dart';
import '../user_model.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider(ref: ref);
});

class UserProvider extends ChangeNotifier {
  final Ref ref;

  UserProvider({required this.ref}) {
    ref.listen<UserModelBase?>(authProvider, (prev, next) {
      if (prev != next) {
        notifyListeners();
      }
    });
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.watch(authProvider);
    final loggingIn = state.matchedLocation == '/login';
    print('user: ${user.runtimeType}');
    if (user == null) {
      return loggingIn ? null : '/login';
    }

    if (user is UserModel) {
      return loggingIn || state.matchedLocation == '/' ? null : '/login';
    }

    if (user is UserModelError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(path: '/', builder: (context, state) => HomeScreen()),
        GoRoute(
          path: '/sign-up',
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
            path: '/sign-up-finish',
            builder: (context, state) => SignUpFinishScreen()),
        GoRoute(path: '/login', builder: (context, state) => LoginScreen())
      ];
}
