import 'package:es3_frontend/products/model/product.dart';
import 'package:es3_frontend/products/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination.dart';
import 'package:collection/collection.dart';

import '../../common/provider/pagination_provider.dart';

final productDetailProvider = Provider.family<Product?, int>((ref, id) {
  final state = ref.watch(productProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.content.firstWhereOrNull((e) => e.id == id);
});

final productProvider = StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductStateNotifier(repository: repository);
});

class ProductStateNotifier extends PaginationProvider<Product, ProductRepository> {
  ProductStateNotifier({required super.repository});

  getDetail({
    required int id,
  }) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getProductDetail(id: id);

    if (pState.content.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(content: <Product>[
        ...pState.content,
        resp,
      ]);
    } else {
      state = pState.copyWith(content: pState.content.map<Product>((e) => e.id == id ? resp : e).toList());
    }
  }
}
