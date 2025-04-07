import 'package:flutter/material.dart';

class MainOptionsButton extends StatelessWidget {
  final String title;
  final String image;

  const MainOptionsButton({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            backgroundColor: Color(0xffF5F5F5),
          ),
          child: SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(this.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('${this.title}', style: TextStyle(fontSize: 12)),
        )
      ],
    );
  }
}
