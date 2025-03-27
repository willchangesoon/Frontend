import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/dio_provider.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final dio = ref.read(dioProvider);
  return CartRepository(dio: dio); // dio 인스턴스는 상황에 맞게 관리
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
}
