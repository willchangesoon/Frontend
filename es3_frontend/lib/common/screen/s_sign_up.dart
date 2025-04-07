import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileKey = GlobalKey<FormState>();

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBarColor: true,
      showBottomNav: false,
      showAppBarBtnBack: true,
      title: 'SIGN UP',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
        child: ListView(children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField('Name'),
                _buildTextField('Email'),
                _buildTextField('Password', isPassword: true),
                _buildTextField('Confirm Password', isPassword: true),
                Form(
                  key: _mobileKey,
                  child: Column(
                    children: [
                      _buildTextField('mobile'),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_mobileKey.currentState!.validate()) {
                              // TODO: Send verification code
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFEB99),
                            foregroundColor: Colors.grey,
                          ),
                          child: const Text('Send Verification Code'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                _buildTextField('Street Address'),
                _buildTextField('Ward/District'),
                _buildTextField('District'),
                _buildTextField('City/Province'),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Enter your birthdate and get a\n',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'special discount coupon\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // 강조 색상
                          fontSize: 16, // 조금 더 크면 강조 효과 UP
                        ),
                      ),
                      TextSpan(
                        text: 'on your birthday!',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime newDate) {},
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Sign up process
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFEB99),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
