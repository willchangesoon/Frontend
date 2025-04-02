import 'package:collection/collection.dart';
import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../user/provider/auth_provider.dart';
import '../component/cart_store_card.dart';
import '../model/cart.dart';
import '../provider/cart_count_provider.dart';
import '../repository/cart_repository.dart';

class CartScreen extends ConsumerStatefulWidget {
  static  String get routeName => 'cart';
  const CartScreen({super.key});


  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<CartItem> _cartItems = [];
  Set<int> selectedIds = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final items = await ref.read(cartRepositoryProvider).getCartItems();
    setState(() {
      _cartItems = items;
      _loading = false;
    });
  }

  Map<String, List<CartItem>> _groupByStore() {
    return groupBy(_cartItems, (item) => item.storeName);
  }

  double _calculateTotal() {
    return _cartItems
        .where((item) => selectedIds.contains(item.cartItemId))
        .fold(
            0.0,
            (sum, item) =>
                sum + (item.price + item.additionalPrice) * item.quantity);
  }

  Future<void> _removeSelected() async {
    final repo = ref.read(cartRepositoryProvider);
    final countNotifier = ref.read(cartCountProvider.notifier);

    final toRemove = _cartItems
        .where((item) => selectedIds.contains(item.cartItemId))
        .toList();

    for (final item in toRemove) {
      await repo.deleteCartItem(item.cartItemId);
      countNotifier.decrease(); // ✅ 수동으로 감소
    }

    setState(() {
      _cartItems.removeWhere((item) => selectedIds.contains(item.cartItemId));
      selectedIds.clear();
    });
  }


  Future<void> _removeSoldOut() async {
    final repo = ref.read(cartRepositoryProvider);
    final countNotifier = ref.read(cartCountProvider.notifier);

    final toRemove = _cartItems.where((item) => item.quantity == 0).toList();

    for (final item in toRemove) {
      await repo.deleteCartItem(item.cartItemId);
      countNotifier.decrease();
    }

    setState(() {
      _cartItems.removeWhere((item) => item.quantity == 0);
    });
  }


  Future<void> _changeQuantity(CartItem item, int delta) async {
    final newQty = item.quantity + delta;
    final repo = ref.read(cartRepositoryProvider);
    final countNotifier = ref.read(cartCountProvider.notifier);

    if (newQty <= 0) {
      await repo.deleteCartItem(item.cartItemId);
      countNotifier.decrease(); // ✅ 수량이 0이면 카운트 감소

      setState(() {
        _cartItems.removeWhere((i) => i.cartItemId == item.cartItemId);
        selectedIds.remove(item.cartItemId);
      });
    } else {
      await repo.updateQuantity(cartItemId: item.cartItemId, quantity: newQty);
      setState(() {
        final idx = _cartItems.indexWhere((i) => i.cartItemId == item.cartItemId);
        _cartItems[idx] = _cartItems[idx].copyWith(quantity: newQty);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    if (user == null) {
      return DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('로그인이 필요합니다.'),
              ElevatedButton(
                onPressed: () => context.push('/login'),
                child: const Text('Login'),
              )
            ],
          ),
        ),
      );
    }

    return DefaultLayout(
      title: '장바구니',
      showBuyBottomNav: true,
      showAppBarBtnBack: true,
      onBuyPressed: () {
        final total = _calculateTotal();
        print('주문하기: $total');
      },
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _removeSelected,
                        child: const Text('선택 삭제'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _removeSoldOut,
                        child: const Text('품절 삭제'),
                      ),
                      const Spacer(),
                      Text(
                        '총 금액: ${_calculateTotal().toStringAsFixed(0)}원',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    child: ListView(
                      children: _groupByStore().entries.map((entry) {
                        final store = entry.key;
                        final items = entry.value;

                        return CartStoreCard(
                          storeName: store,
                          items: items,
                          selectedIds: selectedIds,
                          onQuantityChanged: _changeQuantity,
                          onSelectedChanged: (cartItemId, selected) {
                            setState(() {
                              if (selected) {
                                selectedIds.add(cartItemId);
                              } else {
                                selectedIds.remove(cartItemId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
