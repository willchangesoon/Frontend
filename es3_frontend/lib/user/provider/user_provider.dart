
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import 'auth_provider.dart';

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
}