import 'package:flutter/cupertino.dart';

import '../provider/pagination_provider.dart';

class PaginationUtils {
  static void paginate({
    required int? categoryId,
    required int? storeId,
    required bool? discounted,
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(
        categoryId: categoryId,
        storeId: storeId,
        discounted: discounted,
        fetchMore: true,
      );
    }
  }
}
