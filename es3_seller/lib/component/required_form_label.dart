import 'package:flutter/material.dart';

class RequiredFormLabel extends StatelessWidget {
  final String text;

  const RequiredFormLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$text ',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        Text(
          '*',
          style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
