import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/cart_repository.dart';

final cartCountProvider = StateNotifierProvider<CartCountNotifier, int>((ref) {
  return CartCountNotifier(ref);
});

class CartCountNotifier extends StateNotifier<int> {
  final Ref ref;
  CartCountNotifier(this.ref) : super(0) {
    fetch(); // 초기 로딩
  }

  Future<void> fetch() async {
    final repo = ref.read(cartRepositoryProvider);
    final count = await repo.getCartItemsCount();
    state = count;
  }

  void decrease() {
    if (state > 0) state--;
  }

  void increase() {
    state++;
  }

  void reset() => fetch();
}
