import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final String? discount;
  final double rating;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    this.discount,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // 가로 리스트에서 적절한 크기
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (discount != null)
                      Text(
                        '$discount ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(rating.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
