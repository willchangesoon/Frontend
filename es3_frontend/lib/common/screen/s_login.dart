import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/provider/auth_provider.dart';
import '../../user/repository/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  controller: idController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Mobile'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
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
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authProvider.notifier).login(
                    email: idController.text,
                    password: passwordController.text,
                  );

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인 실패: $e')),
                  );
                }
              },
              child: const Text('로그인'),
            ),
          ),
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
        TextButton(onPressed: (){}, child: Text('Forgot ID/Password?')),
      ],
    );
  }
}
