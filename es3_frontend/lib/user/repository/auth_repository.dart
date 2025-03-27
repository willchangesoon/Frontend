import 'package:dio/dio.dart';
import 'package:es3_frontend/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<void> login({required String email, required String password}) async {
    final response = await dio.post(baseUrl, data: {
      'email': email,
      'password': password,
    });

    final accessToken = response.data['accessToken'];
    final refreshToken = response.data['refreshToken'];

    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
  }
}
