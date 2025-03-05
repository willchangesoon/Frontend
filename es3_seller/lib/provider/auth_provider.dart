import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:es3_seller/const/data.dart';
import 'package:es3_seller/provider/dio_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod/riverpod.dart';

import '../storage/local_storage_provider.dart';
import '../storage/platform_local_storage_interface.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(dio: ref.watch(dioProvider), storage: ref.watch(platformLocalStorageProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IPlatformLocalStorage storage;
  final Dio dio;

  AuthNotifier({required this.dio, required this.storage}) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await dio.post(
        'http://localhost:8080/user-v1/oauth/sellers/sign-in',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'] as String;
        final refreshToken = response.data['refreshToken'] as String;
        storage.setItem(key: ACCESS_TOKEN_KEY,value:  accessToken);
        storage.setItem(key: REFRESH_TOKEN_KEY, value: refreshToken);
        state = AuthState(accessToken: accessToken, refreshToken: refreshToken);
      } else {
        state = state.copyWith(error: 'Login failed: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> signUp({
    required Map<String, dynamic> basicInfo,
    required Map<String, dynamic> businessInfo,
    required Map<String, dynamic> bankInfo,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await dio.post(
        'http://localhost:8080/user-v1/oauth/sellers',
        data: jsonEncode({
          "basicInfo": basicInfo,
          "businessInfo": businessInfo,
          "bankInfo": bankInfo,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final accessToken = response.data['accessToken'] as String;
        final refreshToken = response.data['refreshToken'] as String;

        storage.setItem(key: ACCESS_TOKEN_KEY, value: accessToken);
        storage.setItem(key: REFRESH_TOKEN_KEY, value: refreshToken);
        state = AuthState(accessToken: accessToken, refreshToken: refreshToken);
        return true;
      } else {
        state = state.copyWith(error: 'Signup failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool isAccessTokenExpired() {
    if (state.accessToken == null) return true;
    return JwtDecoder.isExpired(state.accessToken!);
  }

  Future<void> refreshAccessToken() async {
    if (state.refreshToken == null) return;
    try {
      final response = await dio.post(
        'https://your-backend.com/api/auth/refresh',
        data: jsonEncode({'refreshToken': state.refreshToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'] as String;
        // 갱신된 accessToken 저장
        // if (kIsWeb) {
        //   // html.window.localStorage['access_token'] = newAccessToken;
        // } else {
        //   final prefs = await SharedPreferences.getInstance();
        //   await prefs.setString('access_token', newAccessToken);
        // }

        state = state.copyWith(accessToken: newAccessToken);
      } else {
        state = state.copyWith(
            error: 'Token refresh failed: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> logout() async {
    storage.remove(ACCESS_TOKEN_KEY);
    storage.remove(REFRESH_TOKEN_KEY);
    state = AuthState();
  }
}

class AuthState {
  final String? accessToken;
  final String? refreshToken;
  final bool isLoading;
  final String? error;

  AuthState({
    this.accessToken,
    this.refreshToken,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
