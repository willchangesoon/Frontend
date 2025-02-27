import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

import '../component/custom_text_form_field.dart';
import '../const/colors.dart';

class SignUpFirstForm extends StatefulWidget {
  final VoidCallback goBack;
  final VoidCallback onNext;

  const SignUpFirstForm({
    super.key,
    required this.goBack,
    required this.onNext,
  });

  @override
  State<SignUpFirstForm> createState() => _SignUpFirstFormState();
}

class _SignUpFirstFormState extends State<SignUpFirstForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = true; // 버튼 상태 관리

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Basic Info',
              style: TextStyle(fontSize: 16),
            ),
          ),
          RequiredFormLabel(text: 'Account Info'),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'email'),
          const SizedBox(height: 10),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'password'),
          const SizedBox(height: 10),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'confirm password'),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Seller Info'),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'name'),
          const SizedBox(height: 10),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'mobile'),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Market Info'),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'market name'),
          const SizedBox(height: 10),
          CustomTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              text: 'customer support number'),
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.goBack();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isButtonEnabled ? Color(0xff999999) : Color(0xfff5f5f5),
                    ),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        color: _isButtonEnabled ? Colors.white : Color(0xffCCCCCC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // if (!(_formKey.currentState!.validate())) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Not Completed')),
                      //   );
                      // } else {
                      //   widget.onNext();
                      // }
                      widget.onNext();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isButtonEnabled ? MAIN_COLOR : Color(0xfff5f5f5),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: _isButtonEnabled ? Colors.white : Color(0xffCCCCCC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
