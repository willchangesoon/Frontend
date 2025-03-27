import 'package:es3_frontend/common/component/main_carousel.dart';
import 'package:es3_frontend/common/component/review_card.dart';
import 'package:es3_frontend/common/component/store_card.dart';
import 'package:es3_frontend/common/const/colors.dart';
import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/products/model/product_detail_model.dart';
import 'package:es3_frontend/products/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/product_option_bottomsheet.dart';
import '../model/product.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'productDetail';
  final int id;

  const ProductDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(productProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailProvider(widget.id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      showBuyBottomNav: true,
      showAppBarBtnBack: true,
      onBuyPressed: () {
        if (state is ProductDetailModel) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => ProductOptionBottomSheet(
              optionGroups: state.optionGroups,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state is ProductDetailModel)
              MainCarousel(
                aspectRatio: 4 / 5, // 0.8
                margin: EdgeInsets.zero,
                imgList: [state.imageUrl, ...state.additionalImages],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainInfo(product: state),
                Container(height: 5, color: GRAY3_COLOR),
                _shippingInfo(),
                Container(height: 5, color: GRAY3_COLOR),
                const SizedBox(height: 10),
                if (state is ProductDetailModel)
                  StoreCard(
                    logoImg: state.storeLogoImg,
                    storeName: state.storeName,
                  ),
                Divider(),
                _reviewCards(),
                Container(height: 5, color: GRAY3_COLOR),
                if (state is ProductDetailModel) _description()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mainInfo({required Product product}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${product.storeName}  >',
              style: TextStyle(fontStyle: FontStyle.italic, color: GRAY2_COLOR),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              )
            ],
          ),
          const SizedBox(height: 5),
          if (product.discount != null && product.discount! > 0)
            Text(
              '${product.price}vnd',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          Row(
            children: [
              if (product.discount != null && product.discount! > 0)
                Text(
                  '${product.discount}%',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              const SizedBox(width: 5),
              Text(
                '${product.discount != null && (product.discount! > 0) ? product.price * (1 - product.discount! / 100) : product.price} vnd',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shippingInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping', style: TextStyle(color: GRAY1_COLOR)),
              Text('delivered in 1,2 days',
                  style: TextStyle(color: GRAY1_COLOR, fontSize: 10))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment', style: TextStyle(color: GRAY1_COLOR)),
              Text('COD/Bank Transfer/Credit Card',
                  style: TextStyle(color: GRAY1_COLOR, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }

  Widget _description() {
    return Column(
      children: [Text('Information')],
    );
  }
}
