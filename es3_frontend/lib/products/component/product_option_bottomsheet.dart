import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/provider/auth_provider.dart';
import '../model/product_option_group_model.dart';
import '../model/product_sku_model.dart';
import '../../cart/repository/cart_repository.dart';
import 'package:go_router/go_router.dart';

enum ProductOptionMode {
  addToCart,
  changeOption,
}

class ProductOptionBottomSheet extends ConsumerStatefulWidget {
  final List<ProductOptionGroupModel> optionGroups;
  final List<ProductSKUModel> skuList;
  final ProductOptionMode mode;
  final void Function(ProductSKUModel selectedSku)? onOptionSelected;

  const ProductOptionBottomSheet({
    super.key,
    required this.optionGroups,
    required this.skuList,
    required this.mode,
    this.onOptionSelected,
  });

  @override
  ConsumerState<ProductOptionBottomSheet> createState() => _ProductOptionBottomSheetState();
}

class _ProductOptionBottomSheetState extends ConsumerState<ProductOptionBottomSheet> {
  final Map<String, String?> selectedOptions = {};

  ProductSKUModel? findMatchingSKU() {
    final selectedValues = selectedOptions.values.whereType<String>().toList()..sort();

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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedOptions[group.groupName],
                  hint: const Text('옵션 선택'),
                  items: group.options.map((option) {
                    final isDisabled = !widget.skuList.any((sku) =>
                    sku.optionValueList.contains(option.value) && sku.quantity > 0);

                    return DropdownMenuItem<String>(
                      value: option.value,
                      enabled: !isDisabled,
                      child: Text(
                        option.value,
                        style: TextStyle(
                          color: isDisabled ? Colors.grey : Colors.black,
                        ),
                      ),
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
              ElevatedButton(
                onPressed: allSelected
                    ? () async {
                  final matchedSku = findMatchingSKU();
                  if (matchedSku == null || matchedSku.quantity == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('유효한 옵션을 선택해주세요')),
                    );
                    return;
                  }

                  if (widget.mode == ProductOptionMode.addToCart) {
                    if (!isLoggedIn) {
                      Navigator.of(context).pop();
                      if (context.mounted) {
                        context.push('/login');
                      }
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
                  } else if (widget.mode == ProductOptionMode.changeOption) {
                    if (widget.onOptionSelected != null) {
                      widget.onOptionSelected!(matchedSku);
                    }
                    Navigator.of(context).pop();
                  }
                }
                    : null,
                child: Text(
                  widget.mode == ProductOptionMode.addToCart ? '장바구니 담기' : '옵션 변경',
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
