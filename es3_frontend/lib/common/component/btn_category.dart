import 'package:es3_frontend/common/const/colors.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool selected;
  final bool? border;
  final VoidCallback? onPressed;

  const CategoryButton({
    super.key,
    required this.text,
    required this.selected,
    this.onPressed,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: selected == false ? Colors.black87 : Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: selected == false ? Colors.white : MAIN_COLOR,
            elevation: 1.0,
            shape: border! ? RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              side: BorderSide(
                color: selected == false ? Colors.black12 : MAIN_COLOR,
              ),
            ) : null,
          ),
        ),
      ],
    );
  }
}
