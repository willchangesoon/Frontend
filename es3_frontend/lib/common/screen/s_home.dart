import 'package:es3_frontend/common/component/btn_category.dart';
import 'package:es3_frontend/common/component/btn_main_options.dart';
import 'package:es3_frontend/common/component/main_carousel.dart';
import 'package:flutter/material.dart';

import '../../products/model/product.dart';
import '../component/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> mainMenus = ['home', 'rank', 'sale', 'latest', 'brand'];
  int _curSelectedMenu = 0;
  final Map<String, String> options = {
    "First Order": "images/options/first_buy.png",
    "Fast Shipping": "images/options/fast_shipping.png",
    "Last buy": "images/options/last_buy.png",
    "Coupon": "images/options/coupon.png",
  };
  final List<String> categories = ['all', 'clothing', 'bags', 'shoes', 'accessories', 'athletics'];
  int _curSelectedCategory = 0;
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
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderMainMenu(),
          MainCarousel(),
          const SizedBox(height: 10),
          mainOptions(),
          const SizedBox(height: 20),
          listMenu(),
          _buildProductGrid()
        ],
      ),
    );
  }

  Widget renderMainMenu() {
    return Row(
        children: mainMenus.asMap().entries.map((entry) {
          int index = entry.key;
          String menu = entry.value;
          return Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: CategoryButton(
                text: menu,
                selected: _curSelectedMenu == index,
                onPressed: (){
                  setState(() {
                    _curSelectedMenu = index;
                  });
                },
              ),
            ),
          );
        }).toList());
  }

  Widget mainOptions() {
    return Row(
      children: options.entries.map((entry) {
        return Expanded(
          child: MainOptionsButton(title: entry.key, image: entry.value),
        );
      }).toList(),
    );
  }

  Widget listMenu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.asMap().entries.map((entry) {
                int index = entry.key;
                String cat = entry.value;
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: CategoryButton(
                    text: cat,
                    selected: _curSelectedCategory == index,
                    border: _curSelectedCategory != index,
                    onPressed: (){
                      setState(() {
                        _curSelectedCategory = index;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          imageUrl: products[index].imageUrl,
          title: products[index].title,
          subtitle: products[index].subtitle,
          price: products[index].price,
          discount: products[index].discount,
          rating: products[index].rating,
        );
      },
    );
  }
}
