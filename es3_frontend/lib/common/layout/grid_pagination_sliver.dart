import 'package:es3_frontend/common/model/model_with_id.dart';
import 'package:es3_frontend/common/model/cursor_pagination.dart';
import 'package:es3_frontend/common/provider/pagination_provider.dart';
import 'package:es3_frontend/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef GridPaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class GridPaginationSliver<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final int? categoryId;
  final int? storeId;
  final bool? discounted;
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;
  final GridPaginationWidgetBuilder<T> itemBuilder;
  final ScrollController scrollController;

  const GridPaginationSliver({
    required this.categoryId,
    required this.storeId,
    required this.discounted,
    required this.provider,
    required this.itemBuilder,
    required this.scrollController,
    super.key,
  });

  @override
  ConsumerState<GridPaginationSliver<T>> createState() => _GridPaginationSliverState<T>();
}

class _GridPaginationSliverState<T extends IModelWithId>
    extends ConsumerState<GridPaginationSliver<T>> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    // widget.scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    PaginationUtils.paginate(
      controller: widget.scrollController,
      categoryId: widget.categoryId,
      storeId: widget.storeId,
      discounted: widget.discounted,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is CursorPaginationError) {
      return SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: [
              Text(state.message),
              ElevatedButton(
                onPressed: () {
                  ref.read(widget.provider.notifier).paginate(
                    categoryId: widget.categoryId,
                    storeId: widget.storeId,
                    discounted: widget.discounted,
                    forceRefetch: true,
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final cp = state as CursorPagination<T>;

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (index == cp.content.length) {
            return Center(
              child: cp is CursorPaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text('No more data.'),
            );
          }

          final item = cp.content[index];
          return widget.itemBuilder(context, index, item);
        },
        childCount: cp.content.length + 1,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
      ),
    );
  }
}
