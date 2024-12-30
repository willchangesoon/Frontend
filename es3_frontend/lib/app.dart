import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Image.asset(
                  'images/login/kakao_login_medium_narrow.png',
                ),
                onTap: () async {
                  try {
                    OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공 ${token.accessToken}');
                    // await dio.get('http://localhost:85/oauth/kakao/+${token.accessToken}');
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');
                  }
                },
              ),
              Container(height: 10.0,),
              GestureDetector(
                child: Image.asset('images/login/google_login.png'),
                onTap: () async {
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                  print('구글로 로그인 성공 ${googleUser}}');
                },
              ),
              Container(height: 10.0,),
              GestureDetector(
                child: Image.asset('images/login/naver_login.png'),
                onTap: () async {
                  final result = await FlutterNaverLogin.logIn();

                  if (result.status == NaverLoginStatus.loggedIn) {
                    print('accessToken = ${result.accessToken}');
                    print('id = ${result.account.id}');
                    print('email = ${result.account.email}');
                    print('name = ${result.account.name}');

                    print('네이버로 로그인 성공 naver');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
