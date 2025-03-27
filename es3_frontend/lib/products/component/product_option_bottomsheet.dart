import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../cart/repository/cart_repository.dart';
import '../../user/provider/auth_provider.dart';
import '../model/product_option_group_model.dart';
import '../model/product_sku_model.dart';

class ProductOptionBottomSheet extends ConsumerStatefulWidget {
  final List<ProductOptionGroupModel> optionGroups;
  final List<ProductSKUModel> skuList;

  const ProductOptionBottomSheet({
    super.key,
    required this.optionGroups,
    required this.skuList,
  });

  @override
  ConsumerState<ProductOptionBottomSheet> createState() =>
      _ProductOptionBottomSheetState();
}

class _ProductOptionBottomSheetState
    extends ConsumerState<ProductOptionBottomSheet> {
  final Map<String, String?> selectedOptions = {}; // groupName → selected value

  ProductSKUModel? findMatchingSKU() {
    final selectedValues = selectedOptions.values.whereType<String>().toList()
      ..sort();

    for (final sku in widget.skuList) {
      final skuValues = List<String>.from(sku.optionValueList)..sort();

      if (const ListEquality().equals(skuValues, selectedValues)) {
        return sku;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    // 초기화
    for (var group in widget.optionGroups) {
      selectedOptions[group.groupName] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = selectedOptions.values.every((v) => v != null);
    final isLoggedIn = ref.watch(authProvider);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              for (final group in widget.optionGroups) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${group.groupName} 선택',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedOptions[group.groupName],
                  hint: const Text('옵션 선택'),
                  items: group.options.map((option) {
                    return DropdownMenuItem<String>(
                      value: option.value,
                      child: Text(option.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[group.groupName] = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: allSelected
                          ? () async {
                              if (!isLoggedIn) {
                                Navigator.of(context).pop(); // 먼저 바텀시트 닫고
                                if (context.mounted) {
                                  context.push('/login');
                                }
                                return;
                              }

                              final matchedSku = findMatchingSKU();
                              if (matchedSku == null ||
                                  matchedSku.quantity == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('유효한 옵션을 선택해주세요')),
                                );
                                return;
                              }
                              await ref.read(cartRepositoryProvider).addToCart(
                                    skuId: matchedSku.skuId,
                                    quantity: 1,
                                  );
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('장바구니에 담았습니다')),
                              );
                            }
                          : null,
                      child: const Text('장바구니'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: allSelected
                          ? () {
                              final matchedSku = findMatchingSKU();

                              if (matchedSku == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('해당 조합의 상품이 없습니다')),
                                );
                                return;
                              }

                              if (matchedSku.quantity == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('해당 옵션은 품절입니다')),
                                );
                                return;
                              }

                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '선택된 SKU ID: ${matchedSku.skuId}')),
                              );

                              // TODO: matchedSku를 장바구니 or 결제 페이지로 넘기기
                            }
                          : null,
                      child: const Text('구매하기'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
