import 'package:dio/dio.dart';
import 'package:es3_frontend/products/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../common/model/cursor_pagination.dart';
import '../../common/provider/base_pagination_repository.dart';
import '../../common/provider/dio_provider.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ProductRepository(dio, baseUrl: 'http://localhost:8080/order-v1');
  return repository;
});

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<Product> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/common/products')
  Future<CursorPagination<Product>> paginate({
    @Query('cursor') int? cursor,
    @Query('size') int? size,
  });

  // @GET('/{id}')
  // Future<ProductDetailModel> getRestaurantDetail({
  //   @Path() required String id,
  // });
}