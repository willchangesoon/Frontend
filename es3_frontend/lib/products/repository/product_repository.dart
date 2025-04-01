import 'package:dio/dio.dart';
import 'package:es3_frontend/products/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../common/model/cursor_pagination.dart';
import '../../common/provider/base_pagination_repository.dart';
import '../../common/provider/dio_provider.dart';
import '../model/product_detail_model.dart';
import '../model/product_option_group_model.dart';
import '../model/product_sku_model.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ProductRepository(dio,
      baseUrl: 'http://localhost:8080/order-v1/common/products');
  return repository;
});

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<Product> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('')
  Future<CursorPagination<Product>> paginate({
    @Query('cursor') int? cursor,
    @Query('size') int? size,
  });

  @GET('/{id}')
  Future<ProductDetailModel> getProductDetail({
    @Path() required int id,
  });

  @GET('/{id}/skus')
  Future<List<ProductSKUModel>> getSkuList({
    @Path() required int id,
  });

  @GET('/{id}/options')
  Future<List<ProductOptionGroupModel>> getOptionGroups({
    @Path() required int id,
  });
}
