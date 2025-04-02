import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:es3_frontend/user/model/token_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' hide Options;

import '../../common/provider/dio_provider.dart';
import '../../common/provider/secure_storage_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthRepository(dio: dio, storage: storage, baseUrl: 'http://localhost:8080/user-v1/oauth/users/sign-in');
});


class AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;
  final String baseUrl;

  AuthRepository({
    required this.dio,
    required this.storage,
    required this.baseUrl
  });

  Future<TokenResponse> login(
      {required String email, required String password}) async {
    final resp = await dio.post('$baseUrl',
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(headers: {'Content-Type': 'application/json'}));
    return TokenResponse.fromJson(resp.data);
  }

}
