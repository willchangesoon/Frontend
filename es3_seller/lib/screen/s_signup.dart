import 'package:es3_seller/component/page_indicator.dart';
import 'package:es3_seller/form/agree_terms.dart';
import 'package:es3_seller/form/sign_up_second_form.dart';
import 'package:es3_seller/form/sign_up_third_form.dart';
import 'package:flutter/material.dart';

import '../form/sign_up_first_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int signUpStep = 0;

  Widget _buildStepForm() {
    switch (signUpStep) {
      case 0:
        return SignUpFirstForm(
          goBack: () => setState(() => signUpStep = 0),
          onNext: () => setState(() => signUpStep = 1),
        );
      case 1:
        return SignUpSecondForm(
          goBack: () => setState(() => signUpStep = 0),
          onNext: () => setState(() => signUpStep = 2),
        );
      case 2:
        return SignUpThirdForm(
          goBack: () => setState(() => signUpStep = 1),
          onNext: () => setState(() => signUpStep = 3),
        );
      case 3:
        return AgreeTerms(
          goBack: () => setState(() => signUpStep = 2),
          onComplete: () => setState(() => signUpStep = 4),
        );
      default:
        return const Center(child: Text("잘못된 접근입니다."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PageIndicator(text: '1', activate: signUpStep == 0),
                const SizedBox(width: 20),
                PageIndicator(
                    text: '2', activate: signUpStep == 1 || signUpStep == 2),
                const SizedBox(width: 20),
                PageIndicator(text: '3', activate: signUpStep == 3)
              ],
            ),
            const SizedBox(height: 20),
            Text('Let Us Know about You',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildStepForm(),
            ),
            // SignUpSecondForm()
          ],
        ),
      ),
    );
  }
}
