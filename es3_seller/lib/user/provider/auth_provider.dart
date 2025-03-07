import 'package:es3_seller/const/data.dart';
import 'package:es3_seller/user/repository/auth_repository.dart';
import 'package:es3_seller/user/repository/user_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../storage/local_storage_provider.dart';
import '../../storage/platform_local_storage_interface.dart';
import '../user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, UserModelBase?>((ref) {
  IPlatformLocalStorage storage = ref.watch(platformLocalStorageProvider);
  AuthRepository authRepository = ref.watch(authRepositoryProvider);
  UserRepository userRepository = ref.watch(userRepositoryProvider);
  return AuthNotifier(
    storage: storage,
    authRepository: authRepository,
    userRepository: userRepository,
  );
});

class AuthNotifier extends StateNotifier<UserModelBase?> {
  final IPlatformLocalStorage storage;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthNotifier(
      {required this.storage,
      required this.authRepository,
      required this.userRepository})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.getItem(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.getItem(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await userRepository.getMe();

    state = resp;
  }

  Future<UserModelBase> login(String email, String password) async {
    state = UserModelLoading();
    try {
      final resp = await authRepository.login(email: email, password: password);

      await storage.setItem(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.setItem(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResp = await userRepository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  Future<UserModelBase> signUp({
    required Map<String, dynamic> basicInfo,
    required Map<String, dynamic> businessInfo,
    required Map<String, dynamic> bankInfo,
  }) async {
    state = UserModelLoading();
    try {
      final resp = await authRepository.signUp(
          basicInfo: basicInfo, businessInfo: businessInfo, bankInfo: bankInfo);

      storage.setItem(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      storage.setItem(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResp = await userRepository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  // bool isAccessTokenExpired() {
  //   if (state.accessToken == null) return true;
  //   return JwtDecoder.isExpired(state.accessToken!);
  // }

  // Future<void> refreshAccessToken() async {
  //   if (state.refreshToken == null) return;
  //   try {
  //     final response = await dio.post(
  //       'https://your-backend.com/api/auth/refresh',
  //       data: jsonEncode({'refreshToken': state.refreshToken}),
  //       options: Options(headers: {'Content-Type': 'application/json'}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final newAccessToken = response.data['accessToken'] as String;
  //       // 갱신된 accessToken 저장
  //       // if (kIsWeb) {
  //       //   // html.window.localStorage['access_token'] = newAccessToken;
  //       // } else {
  //       //   final prefs = await SharedPreferences.getInstance();
  //       //   await prefs.setString('access_token', newAccessToken);
  //       // }
  //
  //       state = state.copyWith(accessToken: newAccessToken);
  //     } else {
  //       state = state.copyWith(
  //           error: 'Token refresh failed: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     state = state.copyWith(error: e.toString());
  //   }
  // }

  Future<void> logout() async {
    storage.remove(ACCESS_TOKEN_KEY);
    storage.remove(REFRESH_TOKEN_KEY);
    state = null;
  }
}
