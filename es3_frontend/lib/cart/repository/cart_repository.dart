import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/dio_provider.dart';
import '../model/cart.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final dio = ref.read(dioProvider);
  return CartRepository(dio: dio);
});

class CartRepository {
  final Dio dio;

  CartRepository({required this.dio});

  Future<void> addToCart({required int skuId, required int quantity}) async {
    await dio.post(
      'http://localhost:8080/order-v1/carts',
      data: {
        'skuId': skuId,
        'quantity': quantity,
      },
      options: Options(
        headers: {
          'accessToken': 'true',
        },
      ),
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final response = await dio.get(
      'http://localhost:8080/order-v1/carts',
      options: Options(
        headers: {
        'accessToken': 'true',
        }),
    );

    final List<dynamic> data = response.data;
    return data.map((item) => CartItem.fromJson(item)).toList();
  }
}
