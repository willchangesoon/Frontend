import 'dart:async';

import 'package:es3_frontend/products/component/product_rank_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination.dart';
import '../../common/provider/pagination_provider.dart';
import '../../common/utils/pagination_utils.dart';
import '../model/product.dart';

class ProductRankCarousel extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase> provider;

  const ProductRankCarousel({
    required this.provider,
    super.key,
  });

  @override
  ConsumerState<ProductRankCarousel> createState() => _ProductRankCarouselState();
}

class _ProductRankCarouselState extends ConsumerState<ProductRankCarousel> {
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _timer;
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController(); // 페이지 마지막 감지용

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startAutoSlide();
  }

  void _onScroll() {
    PaginationUtils.paginate(
      controller: _scrollController,
      provider: ref.read(widget.provider.notifier),
    );
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final state = ref.read(widget.provider);
      if (state is! CursorPagination) return;

      final pageCount = (state.content.length / 5).ceil();
      if (_currentIndex < pageCount - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Center(child: Text(state.message));
    }

    final cp = state as CursorPagination<Product>;

    return SizedBox(
      height: 600,
      child: PageView.builder(
        controller: _pageController,
        itemCount: (cp.content.length / 5).ceil(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final startIndex = index * 5;
          final List<Widget> cards = [];

          for (int i = 0; i < 5; i++) {
            final productIndex = startIndex + i;
            if (productIndex < cp.content.length) {
              final p = cp.content[productIndex];
              cards.add(ProductRankCard(
                rank: productIndex + 1,
                img: p.imageUrl,
                title: p.title,
                storeName: p.storeName,
                price: p.price.toString(),
              ));
            }
          }

          return Column(children: cards);
        },
      ),
    );
  }
}
