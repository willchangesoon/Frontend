import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _userInfo(),
          Divider(),
          SizedBox(height: 20),
          _history(),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          _orderStatus(),
          SizedBox(height: 30),
          _recentlyViewed(),
          Divider(),
          _csMenus()
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Hello! Username',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              'abcd****@gmail.com',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget _history() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Image.asset('images/mypage/orderlist.png', height: 32),
            Text('Orders'),
            Text(
              'see more',
              style: TextStyle(
                color: Color(0xff7DAA93),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/point.png', height: 32),
            Text('Point'),
            Text(
              '22000',
              style: TextStyle(
                color: Color(0xff7DAA93),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/coupon.png', height: 32),
            Text('Coupon'),
            Text(
              '8',
              style: TextStyle(
                color: Color(0xff7DAA93),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset('images/mypage/review.png', height: 32),
            Text('Review'),
            Text(
              '8',
              style: TextStyle(
                color: Color(0xff7DAA93),
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
            Text(
              'Order Status',
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
      ],
    );
  }

  Widget _csMenus() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
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
