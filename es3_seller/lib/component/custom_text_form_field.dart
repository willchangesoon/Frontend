import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final FormFieldValidator validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.text,
    required this.validator,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.black),
        hintText: text,
        labelText: text,
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}
