import 'package:es3_frontend/user/model/user.dart';
import 'package:es3_frontend/user/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../../common/const/data.dart';
import '../../common/provider/dio_provider.dart';
import '../../common/provider/secure_storage_provider.dart';
import '../repository/user_repository.dart';

final authProvider =
    StateNotifierProvider<AuthStateNotifier, UserModelBase?>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final dio = ref.watch(dioProvider);
  return AuthStateNotifier(
      storage: storage,
      authRepository: authRepository,
      userRepository: userRepository,
      dio: dio);
});

class AuthStateNotifier extends StateNotifier<UserModelBase?> {
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Dio dio;

  AuthStateNotifier({
    required this.storage,
    required this.authRepository,
    required this.userRepository,
    required this.dio,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await userRepository.getMe();

    state = resp;
  }

  /// 로그인 요청 + 토큰 저장 + 상태 변경
  Future<UserModelBase> login(
      {required String email, required String password}) async {
    state = UserModelLoading();
    try {
      final response =
          await authRepository.login(email: email, password: password);

      await storage.write(key: ACCESS_TOKEN_KEY, value: response.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: response.refreshToken);

      final userResp = await userRepository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    await storage.deleteAll();
    state = null;
  }
}
