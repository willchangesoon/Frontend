import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/dio_provider.dart';
import '../model/product.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(
      dio: ref.watch(dioProvider),
      baseUrl: 'http://localhost:8080/order-v1/product');
});

class ProductRepository {
  final Dio dio;
  final String baseUrl;

  ProductRepository({
    required this.dio,
    required this.baseUrl,
  });

  Future<void> createProduct({
    required Product product,
  }) async {
    await dio.post(
      '$baseUrl',
      data: jsonEncode({
        'title' : product.title,
        'visibility' : product.visibility,
        'deliveryType' : product.deliveryType,
        'mainCategory' : product.mainCategoryId,
        'subCategory' : product.subCategoryId,
        'price' : product.price,
        'mainImage' : product.mainImage,
        'additionalImages' : product.additionalImages,
        'description' : product.description,
      }),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
  }
}
