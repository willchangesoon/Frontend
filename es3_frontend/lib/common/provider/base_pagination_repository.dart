import 'package:retrofit/http.dart';

import '../model/cursor_pagination.dart';
import '../model/model_with_id.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    @Query('categoryId') int? categoryId,
    @Query('storeId') int? storeId,
    @Query('discounted') bool? discounted,
    @Query('cursor') int? cursor,
    @Query('size') int? size,
  });
}
