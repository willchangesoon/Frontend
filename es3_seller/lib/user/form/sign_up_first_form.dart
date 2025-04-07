import 'package:es3_seller/component/required_form_label.dart';
import 'package:flutter/material.dart';

import '../../component/custom_text_form_field.dart';
import '../../const/colors.dart';

class SignUpFirstForm extends StatefulWidget {
  final VoidCallback goBack;
  final ValueChanged<Map<String, dynamic>> onNext;

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final marketNameController = TextEditingController();
  final customerSupportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
    nameController.addListener(_updateButtonState);
    mobileController.addListener(_updateButtonState);
    marketNameController.addListener(_updateButtonState);
    customerSupportController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isValid = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        mobileController.text.isNotEmpty &&
        marketNameController.text.isNotEmpty &&
        customerSupportController.text.isNotEmpty &&
        (passwordController.text == confirmPasswordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    mobileController.dispose();
    marketNameController.dispose();
    customerSupportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Basic Info',
              style: TextStyle(fontSize: 16),
            ),
          ),
          RequiredFormLabel(text: 'Account Info'),
          CustomTextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              text: 'email'),
          const SizedBox(height: 10),
          CustomTextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              text: 'password'),
          const SizedBox(height: 10),
          CustomTextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm password';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              text: 'confirm password'),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Seller Info'),
          CustomTextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
              text: 'name'),
          const SizedBox(height: 10),
          CustomTextFormField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter mobile';
                }
                return null;
              },
              text: 'mobile'),
          const SizedBox(height: 20),
          RequiredFormLabel(text: 'Market Info'),
          CustomTextFormField(
              controller: marketNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter market name';
                }
                return null;
              },
              text: 'market name'),
          const SizedBox(height: 10),
          CustomTextFormField(
              keyboardType: TextInputType.phone,
              controller: customerSupportController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter customer support number';
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
                  child: TextButton(
                    onPressed: widget.goBack,
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff999999),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Go Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          "email": emailController.text,
                          "password": passwordController.text,
                          "name": nameController.text,
                          "mobile": mobileController.text,
                        };
                        widget.onNext(data);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MAIN_COLOR.withAlpha(128),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
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
