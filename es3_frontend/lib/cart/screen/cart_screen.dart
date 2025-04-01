import 'package:collection/collection.dart';
import 'package:es3_frontend/common/const/colors.dart';
import 'package:es3_frontend/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../component/cart_store_card.dart';
import '../model/cart.dart';
import '../repository/cart_repository.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  static String get routeName => 'cart-screen';

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  late Future<List<CartItem>> _cartItemsFuture;
  Set<int> selectedIds = {};

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = ref.read(cartRepositoryProvider).getCartItems();
  }

  Map<String, List<CartItem>> _groupByStore(List<CartItem> items) {
    return groupBy(items, (item) => item.storeName);
  }

  double _calculateTotal(List<CartItem> allItems) {
    return allItems
        .where((item) => selectedIds.contains(item.cartItemId))
        .fold(0.0, (sum, item) =>
    sum + (item.price + item.additionalPrice) * item.quantity);
  }

  void _removeSelected(List<CartItem> allItems) {
    setState(() {
      allItems.removeWhere((item) => selectedIds.contains(item.cartItemId));
      selectedIds.clear();
    });
  }

  void _removeSoldOut(List<CartItem> allItems) {
    setState(() {
      allItems.removeWhere((item) => item.quantity == 0);
    });
  }

  void _changeQuantity(CartItem item, int delta) {
    setState(() {
      final newQty = item.quantity + delta;
      if (newQty >= 0) {
        item.quantity = newQty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      showAppBarBtnBack: true,
      showBuyBottomNav: true,
      title: "장바구니",
      onBuyPressed: () {
        final total = _calculateTotal([]);
        print('주문하기: $total');
      },
      child: FutureBuilder<List<CartItem>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!;
          final grouped = _groupByStore(cartItems);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _removeSelected(cartItems),
                      child: const Text('선택 삭제'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _removeSoldOut(cartItems),
                      child: const Text('품절 삭제'),
                    ),
                    const Spacer(),
                    Text(
                      '총 금액: ${_calculateTotal(cartItems).toStringAsFixed(0)}원',
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
                    children: grouped.entries.map((entry) {
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
          );
        },
      ),
    );
  }
}
