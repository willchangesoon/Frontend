import 'dart:async';

import 'package:es3_frontend/common/component/product_rank_card.dart';
import 'package:flutter/material.dart';

import '../../products/model/product.dart';

class ProductRankCarousel extends StatefulWidget {
  const ProductRankCarousel({super.key});

  @override
  State<ProductRankCarousel> createState() => _ProductRankCarouselState();
}

class _ProductRankCarouselState extends State<ProductRankCarousel> {
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _timer;
  int _currentIndex = 0;
  final List<Product> products = [
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "하이브",
      subtitle: "니트 스판 바디수트",
      price: "38,000",
      discount: "10%",
      rating: 4.8,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "화이트걸",
      subtitle: "라이트 탱크탑",
      price: "38,000",
      discount: null,
      rating: 4.6,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "니스바",
      subtitle: "순면 라인 나시",
      price: "18,000",
      discount: "20%",
      rating: 4.4,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "순라나",
      subtitle: "데일리로 입기 좋은 반팔",
      price: "18,000",
      discount: null,
      rating: 4.5,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "하이브",
      subtitle: "니트 스판 바디수트",
      price: "38,000",
      discount: "10%",
      rating: 4.8,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "하이브",
      subtitle: "니트 스판 바디수트",
      price: "38,000",
      discount: "10%",
      rating: 4.8,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "화이트걸",
      subtitle: "라이트 탱크탑",
      price: "38,000",
      discount: null,
      rating: 4.6,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "니스바",
      subtitle: "순면 라인 나시",
      price: "18,000",
      discount: "20%",
      rating: 4.4,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "순라나",
      subtitle: "데일리로 입기 좋은 반팔",
      price: "18,000",
      discount: null,
      rating: 4.5,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "하이브",
      subtitle: "니트 스판 바디수트",
      price: "38,000",
      discount: "10%",
      rating: 4.8,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "순라나",
      subtitle: "데일리로 입기 좋은 반팔",
      price: "18,000",
      discount: null,
      rating: 4.5,
    ),
    Product(
      imageUrl: "assets/images/sample/img.png",
      title: "하이브",
      subtitle: "니트 스판 바디수트",
      price: "38,000",
      discount: "10%",
      rating: 4.8,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < (products.length / 5).ceil() - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: PageView.builder(
        controller: _pageController,
        itemCount: (products.length / 5).ceil(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          int startIndex = index * 5;
          List<Widget> cardWidgets = [];
          for (int i = 0; i < 5; i++) {
            int productIndex = startIndex + i;
            if (productIndex < products.length) {
              cardWidgets.add(
                ProductRankCard(
                  rank: productIndex+1,
                  img: products[productIndex].imageUrl,
                  title: products[productIndex].title,
                  storeName: products[productIndex].subtitle,
                  price: products[productIndex].price,
                ),
              );
            }
          }
          return Column(
            children: cardWidgets,
          );
        },
      ),
    );
  }
}
