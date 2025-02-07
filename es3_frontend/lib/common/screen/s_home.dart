import 'package:es3_frontend/common/component/btn_category.dart';
import 'package:es3_frontend/common/component/btn_main_options.dart';
import 'package:es3_frontend/common/component/main_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> mainMenus = ['home', 'ranking', 'sale', 'latest', 'brand'];
  int _curSelectedMenu = 0;
  final Map<String, String> options = {
    "First Order": "images/options/first_buy.png",
    "Fast Shipping": "images/options/fast_shipping.png",
    "Last buy": "images/options/last_buy.png",
    "Coupon": "images/options/coupon.png",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderMainMenu(),
          MainCarousel(),
          const SizedBox(height: 10),
          mainOptions(),
          const SizedBox(height: 40),
          listMenu()
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              CategoryButton(
                text: 'bag',
                selected: false,
                border: true,
              ),
              CategoryButton(text: 'shoes', selected: true),
            ],
          )
        ],
      ),
    );
  }
}
