import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      inputFormatters: <TextInputFormatter>[
        keyboardType == TextInputType.number
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
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
