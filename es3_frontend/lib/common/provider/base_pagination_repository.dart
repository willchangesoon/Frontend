import 'package:retrofit/http.dart';

import '../model/cursor_pagination.dart';
import '../model/model_with_id.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    @Query('cursor') int? cursor,
    @Query('size') int? size,
  });
}
