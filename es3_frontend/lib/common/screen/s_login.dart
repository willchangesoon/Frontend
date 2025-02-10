import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool saveLogin = false;
  bool saveMobile = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      showBottomNav: false,
      showAppBarBtnBack: true,
      title: 'LOGIN',
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
            child: Column(
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Mobile'),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: saveLogin,
                      onChanged: (bool) {
                        setState(() {
                          saveLogin = bool!;
                        });
                      },
                    ),
                    Text('Remember Me'),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: saveMobile,
                      onChanged: (bool) {
                        setState(() {
                          saveMobile = bool!;
                        });
                      },
                    ),
                    Text('Remember Mobile')
                  ],
                ),
                renderSocialLoginBtns(),
                renderFindBtns()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderSocialLoginBtns() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        children: [
          Image.asset('images/login/img.png'),
          const SizedBox(height: 10),
          Image.asset('images/login/img_1.png'),
          const SizedBox(height: 10),
          Image.asset('images/login/img_2.png'),
        ],
      ),
    );
  }

  Widget renderFindBtns() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: (){}, child: Text('Sign Up')),
        const SizedBox(
          height: 15,
          child: VerticalDivider(color: Colors.grey),
        ),
        TextButton(onPressed: (){}, child: Text('Forgot ID?')),
        const SizedBox(
          height: 15,
          child: VerticalDivider(color: Colors.grey),
        ),
        TextButton(onPressed: (){}, child: Text('Forgot Password?')),
      ],
    );
  }
}
