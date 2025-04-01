import 'package:es3_frontend/cart/component/cart_item_card.dart';
import 'package:flutter/material.dart';
import '../model/cart.dart';

class CartStoreCard extends StatelessWidget {
  final String storeName;
  final List<CartItem> items;
  final Set<int> selectedIds;
  final void Function(CartItem item, int delta) onQuantityChanged;
  final void Function(int cartItemId, bool selected) onSelectedChanged;

  const CartStoreCard({
    super.key,
    required this.storeName,
    required this.items,
    required this.selectedIds,
    required this.onQuantityChanged,
    required this.onSelectedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$storeName 배송상품",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...items.map((item) {
              return CartItemCard(
                item: item,
                selected: selectedIds.contains(item.cartItemId),
                onToggle: (checked) {
                  onSelectedChanged(item.cartItemId, checked!);
                },
                onIncrement: () => onQuantityChanged(item, 1),
                onDecrement: () => onQuantityChanged(item, -1),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
