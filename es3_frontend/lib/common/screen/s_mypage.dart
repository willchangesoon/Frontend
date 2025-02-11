import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: Text('login'),
          onPressed: () {
            context.push('/login');
          },
        ),
        TextButton(
          child: Text('sign up'),
          onPressed: () {
            context.push('/sign-up');
          },
        ),
      ],
    );
  }
}
