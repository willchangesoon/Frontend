import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../../common/const/data.dart';
import '../../common/provider/dio_provider.dart';
import '../../common/provider/secure_storage_provider.dart';

final authProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final dio = ref.watch(dioProvider);
  return AuthStateNotifier(storage: storage, dio: dio);
});


class AuthStateNotifier extends StateNotifier<bool> {
  final FlutterSecureStorage storage;
  final Dio dio;

  AuthStateNotifier({
    required this.storage,
    required this.dio,
  }) : super(false);

  /// 로그인 요청 + 토큰 저장 + 상태 변경
  Future<void> login({required String email, required String password}) async {
    final response = await dio.post('http://localhost:8080/user-v1/oauth/users/sign-in', data: {
      'email': email,
      'password': password,
    });

    final accessToken = response.data['accessToken'];
    final refreshToken = response.data['refreshToken'];

    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);

    state = true;
  }

  /// 로그아웃
  Future<void> logout() async {
    await storage.deleteAll();
    state = false;
  }

  /// 앱 시작 시 로그인 상태 복원
  Future<void> restore() async {
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    state = token != null;
  }
}
