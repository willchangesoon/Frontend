import 'package:es3_seller/component/page_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../user/form/agree_terms.dart';
import '../user/form/sign_up_first_form.dart';
import '../user/form/sign_up_second_form.dart';
import '../user/form/sign_up_third_form.dart';
import '../user/provider/auth_provider.dart';
import '../user/user_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  int signUpStep = 0;
  Map<String, dynamic>? basicInfo;
  Map<String, dynamic>? businessInfo;
  Map<String, dynamic>? bankInfo;

  Widget _buildStepForm() {
    switch (signUpStep) {
      case 0:
        return SignUpFirstForm(
          goBack: () => setState(() => signUpStep = 0),
          onNext: (Map<String, dynamic> data) {
            setState(() {
              basicInfo = data;
              signUpStep = 1;
            });
          },
        );
      case 1:
        return SignUpSecondForm(
          goBack: () => setState(() => signUpStep = 0),
          onNext: (Map<String, dynamic> data) {
            setState(() {
              businessInfo = data;
              signUpStep = 2;
            });
          },
        );
      case 2:
        return SignUpThirdForm(
          goBack: () => setState(() => signUpStep = 1),
          onNext: (Map<String, dynamic> data) {
            setState(() {
              bankInfo = data;
              signUpStep = 3;
            });
          },
        );
      case 3:
        return AgreeTerms(
          goBack: () => setState(() => signUpStep = 2),
          onComplete: () async {
            if (basicInfo != null && businessInfo != null && bankInfo != null) {
              UserModelBase result =
                  await ref.read(authProvider.notifier).signUp(
                        basicInfo: basicInfo!,
                    businessInfo: businessInfo!,
                    bankInfo: bankInfo!,
                  );
              context.go('/sign-up-finish');
            }
          },
        );
      default:
        return const Center(child: Text("잘못된 접근입니다."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SizedBox(
            width: kIsWeb ? 420 : null,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PageIndicator(text: '1', activate: signUpStep == 0),
                      const SizedBox(width: 20),
                      PageIndicator(
                          text: '2',
                          activate: signUpStep == 1 || signUpStep == 2),
                      const SizedBox(width: 20),
                      PageIndicator(text: '3', activate: signUpStep == 3)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Let Us Know about You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _buildStepForm(),
                  ),
                  // SignUpSecondForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
