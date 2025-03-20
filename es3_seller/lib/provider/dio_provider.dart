import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:es3_seller/storage/local_storage_provider.dart';
import 'package:es3_seller/storage/platform_local_storage_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/data.dart';
import '../user/provider/auth_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(platformLocalStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));

  return dio;
});

class CustomInterceptor extends Interceptor {
  final IPlatformLocalStorage storage;
  final Ref ref;

  CustomInterceptor({required this.ref, required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] [${options.uri}]');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.getItem(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.getItem(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');
    print('err response -> ${err}');
    final refreshToken = await storage.getItem(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus406 = err.response?.statusCode == 406;
    final isPathRefresh =
        err.requestOptions.path == '/user-v1/oauth/sellers/refresh';

    // ExceptionResponse exceptionResponse =
    //     ExceptionResponse.fromJson(err.response?.data);

    if (isStatus406 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
            'http://localhost:8080/user-v1/oauth/sellers/refresh',
            data: jsonEncode({"refreshToken": refreshToken}),
            options: Options(headers: {'Content-Type': 'application/json'}));

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        //토큰 변경
        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        storage.setItem(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요청 재전송
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } catch (e, stack) {
        print(e);
        print(stack);
        await ref.read(authProvider.notifier).logout();
        return handler.reject(err);
      }
    }
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] [${response.requestOptions.uri}]');

    return super.onResponse(response, handler);
  }
}
