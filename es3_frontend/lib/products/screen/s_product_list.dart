import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:es3_frontend/common/layout/grid_pagination_listview.dart';
import 'package:es3_frontend/products/provider/product_provider.dart';
import 'package:es3_frontend/products/screen/s_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../component/product_card.dart';
class ProductListScreen extends ConsumerStatefulWidget {
  static String get routeName => 'product-list';
  final int categoryId;

  const ProductListScreen({
    super.key,
    required this.categoryId,
  });

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    // 카테고리 기반으로 강제 리패치
    Future.microtask(() {
      ref.read(productProvider.notifier).paginate(
        categoryId: widget.categoryId,
        forceRefetch: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: GridPaginationListView(
        categoryId: widget.categoryId,
        storeId: null,
        discounted: null,
        provider: productProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
            child: ProductCard.fromModel(model: model),
            onTap: () {
              context.pushNamed(
                ProductDetailScreen.routeName,
                pathParameters: {'pid': (model.id).toString()},
              );
            },
          );
        },
      ),
    );
  }
}
