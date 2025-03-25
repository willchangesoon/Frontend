import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String shopName;
  final int price;
  final int? discount;
  final double? rating;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.shopName,
    required this.price,
    this.discount,
    required this.rating,
  });

  factory ProductCard.fromModel({
    required Product model,
    bool isDetail = false,
  }) {
    return ProductCard(
      imageUrl: model.imageUrl,
      title: model.title,
      shopName: model.storeName,
      price: model.price,
      rating: model.rating,
      discount: model.discount,
    );
  }

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
              child: Image.network(
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
                    if (discount != 0)
                      Text(
                        '${discount.toString()}% ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      '$price원',
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
                  shopName,
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                // Row(
                //   children: [
                //     Icon(Icons.star, color: Colors.amber, size: 16),
                //     Text(rating.toString()),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
