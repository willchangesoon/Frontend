import 'package:es3_seller/const/colors.dart';
import 'package:es3_seller/form/sign_up_first_form.dart';
import 'package:es3_seller/screen/s_sign_up_finish.dart';
import 'package:es3_seller/screen/s_signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'GmarketSans',
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SignUpScreen(),
        ),
      ),
    );
  }
}
