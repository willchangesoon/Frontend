import 'package:es3_frontend/common/component/btn_category.dart';
import 'package:es3_frontend/common/component/btn_main_options.dart';
import 'package:es3_frontend/common/component/main_carousel.dart';
import 'package:es3_frontend/products/component/product_rank_card.dart';
import 'package:es3_frontend/common/const/colors.dart';
import 'package:es3_frontend/products/provider/product_provider.dart';
import 'package:es3_frontend/products/screen/s_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../products/component/product_rank_carousel.dart';
import '../../products/model/product.dart';
import '../../products/component/product_card.dart';
import '../layout/grid_pagination_listview.dart';

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
  final List<String> categories = [
    'all',
    'clothing',
    'bags',
    'shoes',
    'accessories',
    'athletics'
  ];
  int _curSelectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderMainMenu(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MainCarousel(
              aspectRatio: 1.0,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              imgList: [
                'https://dmd-studios.com/uploads/by_product/sku-777/d0196aba3ee1cd86fe6fee5ee7971a52.jpg',
                'https://dmd-studios.com/uploads/by_product/sku-752/f546ec1db15c50b7748bf4711812e36c.JPG',
                'https://dmd-studios.com/uploads/by_product/sku-744/9342724ed1bee470cb5aa9de7aefda56.jpg',
              ],
            ),
          ),
          const SizedBox(height: 10),
          mainOptions(),
          const SizedBox(height: 20),
          _buildProductRank(),
          const SizedBox(height: 20),
          listMenu(),
          _buildProductGrid()
        ],
      ),
    );
  }

  Widget renderMainMenu() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        for (int i = 0; i < mainMenus.length; i++) ...[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _curSelectedMenu = i;
                    });
                  },
                  child: Text(
                    mainMenus[i],
                    style: TextStyle(
                      color: i == _curSelectedMenu ? MAIN_COLOR : GRAY2_COLOR,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 마지막 버튼 뒤에는 Divider를 넣지 않음
          if (i < mainMenus.length - 1)
            const SizedBox(
              height: 24,
              width: 1, // 너비를 1로 설정
              child: VerticalDivider(
                  thickness: 1, color: GRAY2_COLOR, endIndent: 3, indent: 3),
            ),
        ],
      ],
    );
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: CategoryButton(
                    text: cat,
                    selected: _curSelectedCategory == index,
                    border: _curSelectedCategory != index,
                    onPressed: () {
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

  Widget _buildProductRank() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ranking',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ProductRankCarousel(
            provider: productProvider,
          )
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridPaginationListView(
        provider: productProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
              child: ProductCard.fromModel(model: model),
              onTap: () {
                context.pushNamed(
                  ProductDetailScreen.routeName,
                  pathParameters: {'pid': (model.id).toString()},
                );
              });
        });
  }
}
