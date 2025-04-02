import 'package:dio/dio.dart';
import 'package:es3_frontend/cart/provider/cart_count_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/dio_provider.dart';
import '../model/cart.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final dio = ref.read(dioProvider);
  return CartRepository(dio: dio);
});

class CartRepository {
  final Dio dio;

  CartRepository({ required this.dio});

  Future<void> addToCart({required int skuId, required int quantity}) async {
    await dio.post(
      'http://localhost:8080/order-v1/carts',
      data: {
        'skuId': skuId,
        'quantity': quantity,
      },
      options: Options(headers: {'accessToken': 'true'}),
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final response = await dio.get(
      'http://localhost:8080/order-v1/carts',
      options: Options(headers: {'accessToken': 'true'}),
    );

    final List<dynamic> data = response.data;
    return data.map((item) => CartItem.fromJson(item)).toList();
  }

  Future<int> getCartItemsCount() async {
    final response = await dio.get(
      'http://localhost:8080/order-v1/carts/count',
      options: Options(headers: {'accessToken': 'true'}),
    );
    return response.data;
  }

  Future<void> updateQuantity({
    required int cartItemId,
    required int quantity,
    int? skuId,
  }) async {
    final data = {
      'quantity': quantity,
      if (skuId != null) 'skuId': skuId,
    };

    await dio.patch(
      'http://localhost:8080/order-v1/carts/$cartItemId',
      data: data,
      options: Options(headers: {'accessToken': 'true'}),
    );
  }

  Future<void> deleteCartItem(int cartItemId) async {
    await dio.delete(
      'http://localhost:8080/order-v1/carts/$cartItemId',
      options: Options(headers: {'accessToken': 'true'}),
    );
  }
}
