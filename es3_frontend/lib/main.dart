import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'a4f326492511110af63a97490ab9c839',
    javaScriptAppKey: '4421fd8653c4ef00df23eef12cc354b2',
  );
  runApp(App());
}
