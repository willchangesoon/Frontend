import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:es3_seller/user/model/token_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/dio_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(
      dio: dio, baseUrl: 'http://localhost:8080/user-v1/oauth/sellers');
});

class AuthRepository {
  final Dio dio;
  final String baseUrl;

  AuthRepository({required this.dio, required this.baseUrl});

  Future<TokenResponse> login(
      {required String email, required String password}) async {
    final resp = await dio.post('$baseUrl/sign-in',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}));
    return TokenResponse.fromJson(resp.data);
  }

  Future<TokenResponse> signUp({
    required Map<String, dynamic> basicInfo,
    required Map<String, dynamic> businessInfo,
    required Map<String, dynamic> bankInfo,
  }) async {
    final resp = await dio.post(
      '$baseUrl',
      data: jsonEncode({
        "basicInfo": basicInfo,
        "businessInfo": businessInfo,
        "bankInfo": bankInfo,
      }),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    return TokenResponse.fromJson(resp.data);
  }
}
