import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../common/provider/dio_provider.dart';
import '../model/category.dart';

part 'category_repository.g.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dio = ref.read(dioProvider);
  return CategoryRepository(dio, baseUrl: 'http://localhost:8080/order-v1/common/categories');
});

@RestApi()
abstract class CategoryRepository {
  factory CategoryRepository(Dio dio, {String baseUrl}) = _CategoryRepository;

  @GET('')
  Future<List<CategoryModel>> getCategories();
}
