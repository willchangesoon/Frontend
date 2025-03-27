import 'package:flutter/material.dart';

class ProductRankCard extends StatelessWidget {
  final int rank;
  final String img;
  final String title;
  final String storeName;
  final String price;

  const ProductRankCard({
    super.key,
    required this.rank,
    required this.img,
    required this.title,
    required this.storeName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // 원하는 높이가 있다면 SizedBox로 감싸 고정 높이 지정 가능
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 세로 축 정렬
        children: [
          // 순위 표시 (너비 고정)
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          // 이미지 (너비 고정)
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          // 텍스트 영역 (남은 공간 차지)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(price),
              ],
            ),
          ),
          // 즐겨찾기 아이콘
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
