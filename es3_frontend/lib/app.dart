import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: InkWell(
            child: Image.asset(
              'images/login/kakao_login_medium_narrow.png',
            ),
            onTap: () async {
              try {
                OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
                print('카카오톡으로 로그인 성공 ${token.accessToken}');
                await dio.get('http://localhost:85/oauth/kakao/+${token.accessToken}');
              } catch (error) {
                print('카카오톡으로 로그인 실패 $error');
              }
            },
          ),
        ),
      ),
    );
  }
}
