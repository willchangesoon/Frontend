import 'package:es3_frontend/products/component/product_card.dart';
import 'package:es3_frontend/user/model/user.dart';
import 'package:es3_frontend/user/provider/auth_provider.dart';
import 'package:es3_frontend/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../products/model/product.dart';
import '../const/colors.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  const MyPageScreen({super.key});

  @override
  ConsumerState<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen> {
  // final List<Product> products = [
  //   Product(
  //     id: 0,
  //     imageUrl: "assets/images/sample/img.png",
  //     title: "하이브",
  //     storeName: "니트 스판 바디수트",
  //     price: 12900,
  //     discount: 10,
  //     rating: 4.8,
  //   ),
  //   Product(
  //     id: 0,
  //     imageUrl: "assets/images/sample/img.png",
  //     title: "화이트걸",
  //     storeName: "라이트 탱크탑",
  //     price: 23800,
  //     discount: null,
  //     rating: 4.6,
  //   ),
  //   Product(
  //     id: 0,
  //     imageUrl: "assets/images/sample/img.png",
  //     title: "니스바",
  //     storeName: "순면 라인 나시",
  //     price: 18000,
  //     discount: 20,
  //     rating: 4.4,
  //   ),
  //   Product(
  //     id: 0,
  //     imageUrl: "assets/images/sample/img.png",
  //     title: "순라나",
  //     storeName: "데일리로 입기 좋은 반팔",
  //     price: 230000,
  //     discount: null,
  //     rating: 4.5,
  //   ),
  //   Product(
  //     id: 0,
  //     imageUrl: "assets/images/sample/img.png",
  //     title: "하이브",
  //     storeName: "니트 스판 바디수트",
  //     price: 10000,
  //     discount: 10,
  //     rating: 4.8,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            _userInfo(user),
            Divider(),
            _history(),
            Divider(),
            _orderStatus(),
            Divider(),
            _recentlyViewed(),
            Divider(),
            _csMenus()
          ],
        ),
      ),
    );
  }

  Widget _userInfo(state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (state is UserModel)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello! ${state.name}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                '${state.email}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: GRAY2_COLOR,
                ),
              ),
            ],
          ),
        if (state == null)
          GestureDetector(
            onTap: () => context.push('/login'),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Click here to Login',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        if (state is UserModelLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        IconButton(
          onPressed: () {
            context.push('/mypage/setting');
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget _history() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset('images/mypage/orderlist.png', height: 32),
            const Text(
              'Orders',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Text(
              'see more',
              style: TextStyle(color: SUB_COLOR, fontSize: 12),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/point.png', height: 32),
            const Text(
              'Point',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Text(
              '22000',
              style: TextStyle(
                fontSize: 12,
                color: SUB_COLOR,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/coupon.png', height: 32),
            const Text(
              'Coupon',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Text(
              '8',
              style: TextStyle(
                fontSize: 12,
                color: SUB_COLOR,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/review.png', height: 32),
            const Text(
              'Review',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Text(
              '8',
              style: TextStyle(
                color: SUB_COLOR,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderStatus() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_right,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('0'),
                Text(
                  'Received',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Icon(Icons.chevron_right),
            Column(
              children: [
                Text('0'),
                Text(
                  'Preparing',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Icon(Icons.chevron_right),
            Column(
              children: [
                Text('0'),
                Text(
                  'Shipping',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Icon(Icons.chevron_right),
            Column(
              children: [
                Text('0'),
                Text(
                  'Complete',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _recentlyViewed() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Viewed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_right,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        // SizedBox(
        //   height: 270,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: products.length,
        //     itemBuilder: (context, index) {
        //       return ProductCard.fromModel(model: products[index]);
        //     },
        //   ),
        // )
      ],
    );
  }

  Widget _csMenus() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Help Center',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text('Contact us'),
          Text('Notices'),
          Text('FAQ'),
        ],
      ),
    );
  }
}
