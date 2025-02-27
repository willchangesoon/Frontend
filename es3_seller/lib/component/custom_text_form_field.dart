import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final FormFieldValidator validator;
  const CustomTextFormField({
    super.key,
    required this.text,
    required this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
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
