import 'package:es3_seller/const/colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final bool activate;
  final String text;

  const PageIndicator({
    super.key,
    required this.text,
    this.activate = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: activate == true ? MAIN_COLOR : MEDIUM_GRAY,
      radius: 12,
      child: Text(
        text,
        style: TextStyle(
          color: activate == true ? Colors.black : Color(0xff999999),
          fontSize: 12,
        ),
      ),
    );
  }
}
