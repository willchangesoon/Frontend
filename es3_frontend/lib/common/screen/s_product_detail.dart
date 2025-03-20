import 'package:es3_frontend/common/component/main_carousel.dart';
import 'package:es3_frontend/common/component/review_card.dart';
import 'package:es3_frontend/common/component/store_card.dart';
import 'package:es3_frontend/common/const/colors.dart';
import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      showBuyBottomNav: true,
      showAppBarBtnBack: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainCarousel(
              aspectRatio: 4 / 5, // 0.8
              margin: EdgeInsets.zero,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'birchwood  >',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: GRAY2_COLOR),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unisex Hoodie',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_border))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text('620,000vnd',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      )),
                  Row(
                    children: [
                      Text(
                        '30%',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '620,000vnd',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('shipping info',
                          style: TextStyle(color: GRAY1_COLOR)),
                      Text('delivered in 1,2 days',
                          style: TextStyle(color: GRAY1_COLOR, fontSize: 10))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Methods',
                          style: TextStyle(color: GRAY1_COLOR)),
                      Text('COD/Bank Transfer/Credit Card',
                          style: TextStyle(color: GRAY1_COLOR, fontSize: 10)),
                    ],
                  ),
                  Divider(),
                  // ReviewCard(),
                  Text('Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ReviewCard(),
                        ReviewCard(),
                        ReviewCard(),
                      ],
                    ),
                  ),
                  Divider(),
                  StoreCard(),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
