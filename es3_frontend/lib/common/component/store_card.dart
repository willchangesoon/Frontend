import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  final String logoImg;
  final String storeName;

  const StoreCard({
    super.key,
    required this.logoImg,
    required this.storeName,
  });

  factory StoreCard.fromModel({
    required String logoImg,
    required String storeName,
  }) {
    return StoreCard(
      logoImg: logoImg,
      storeName: storeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(logoImg),
            radius: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                storeName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}
