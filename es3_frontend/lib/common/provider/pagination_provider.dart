import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cursor_pagination.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';
import 'base_pagination_repository.dart';

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int? categoryId,
    int? storeId,
    bool? discounted,
    int fetchCount = 10,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      //바로 반환하는 상황
      //1) hasMore = false (받아올 데이터가 더이상 없을때)
      //2) 로딩중 -> fetchMore= true -> (추가데이터를 요청할때는 기존에 갖고 있는거를 유지해야함)

      //1번 반환 상황
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.hasNext) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore<T>;

      //2번 반환 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      //pagination params 생성
      PaginationParams paginationParams = PaginationParams(
        size: fetchCount,
      );

      //fetchMore 데이터를 추가로 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore<T>(
          hasNext: pState.hasNext,
          nextCursor: pState.nextCursor,
          content: pState.content,
        );
        paginationParams = paginationParams.copyWith(
          cursor: pState.content.last.id,
        );
      } else {
        //데이터를 처음부터 가져오는 상황
        //만약 데이터가 있다면 기존 데이터를 보존한채로 fetch를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            hasNext: pState.hasNext,
            nextCursor: pState.nextCursor,
            content: pState.content,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        categoryId: categoryId,
        storeId: storeId,
        discounted: discounted,
        cursor: paginationParams.cursor,
        size: paginationParams.size,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        state = resp.copyWith(content: [
          ...pState.content,
          ...resp.content,
        ]);
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: e.toString());
    }
  }
}
