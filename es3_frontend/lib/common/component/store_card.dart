import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/bw/logo.png'),
            radius: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('birchwood', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
            ],
          ),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}
