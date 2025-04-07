import 'package:es3_frontend/products/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/component/product_option_bottomsheet.dart';
import '../model/cart.dart';

class CartItemCard extends ConsumerWidget {
  final CartItem item;
  final bool selected;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCard({
    super.key,
    required this.item,
    required this.selected,
    required this.onToggle,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final originalPrice = item.price + item.additionalPrice;
    final discountRate = item.discount;
    final discountedPrice =
        (originalPrice * (100 - discountRate) / 100).floorToDouble();
    final perUnitPrice = discountedPrice;
    final totalPrice = perUnitPrice * item.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productTitle,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showOptionChangeBottomSheet(ref, context, item.productId),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(item.optionSummary, style: const TextStyle(fontSize: 12)),
                                const Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: onDecrement,
                        ),
                        Text('${item.quantity}개'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: onIncrement,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: selected,
                onChanged: onToggle,
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text('price/1pcs: '),
              ),
              if (discountRate > 0)
                Text(
                  '${originalPrice.toStringAsFixed(0)}원',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              if (discountRate > 0) const SizedBox(width: 6),
              Text(
                '${perUnitPrice.toStringAsFixed(0)}원',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 4),
          // Text(
          //   '총 ${totalPrice.toStringAsFixed(0)}원',
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 15,
          //     color: Colors.black87,
          //   ),
          // ),
        ],
      ),
    );
  }

  void _showOptionChangeBottomSheet(WidgetRef ref, BuildContext context, int productId) async {
    final optionGroups = await ref.read(productRepositoryProvider).getOptionGroups(id: productId);
    final skuList = await ref.read(productRepositoryProvider).getSkuList(id: productId);

    if (!context.mounted) return;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductOptionBottomSheet(
        optionGroups: optionGroups,
        skuList: skuList,
        mode: ProductOptionMode.changeOption,
        onOptionSelected: (selectedSku) {
          // TODO: 선택된 SKU로 장바구니 아이템 변경 처리 (예: PATCH 요청)
          print('선택된 SKU: ${selectedSku.skuId}');
        },
      ),
    );
  }

}
