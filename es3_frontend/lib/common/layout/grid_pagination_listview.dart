import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cursor_pagination.dart';
import '../model/model_with_id.dart';
import '../provider/pagination_provider.dart';
import '../utils/pagination_utils.dart';

typedef GridPaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class GridPaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final GridPaginationWidgetBuilder<T> itemBuilder;

  const GridPaginationListView({
    required this.provider,
    required this.itemBuilder,
    super.key,
  });

  @override
  ConsumerState<GridPaginationListView> createState() =>
      _GridPaginationListViewState<T>();
}

class _GridPaginationListViewState<T extends IModelWithId>
    extends ConsumerState<GridPaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    //완전 첫 로딩
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    //에러
    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            child: Text(
              '다시시도',
            ),
          )
        ],
      );
    }

    final cp = state as CursorPagination<T>;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(widget.provider.notifier).paginate(forceRefetch: true);
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        itemCount: cp.content.length + 1,
        // 로딩 or 마지막 메시지 칸 추가
        itemBuilder: (context, index) {
          if (index == cp.content.length) {
            // 마지막 칸: 로딩 중이거나 '마지막입니다' 텍스트
            return Center(
              child: cp is CursorPaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text('마지막 데이터입니다.'),
            );
          }

          final pItem = cp.content[index];

          return widget.itemBuilder(context, index, pItem);
        },
      ),
    );
  }
}
