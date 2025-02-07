import 'package:es3_frontend/common/component/btn_category.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CategoryButton(text: 'bag', selected: false, border: true,),
              CategoryButton(text: 'shoes', selected: true),
            ],
          )
        ],
      ),
    );
  }
}
