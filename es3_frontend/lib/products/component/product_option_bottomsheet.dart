import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_option_group_model.dart';

class ProductOptionBottomSheet extends ConsumerStatefulWidget {
  final List<ProductOptionGroupModel> optionGroups;

  const ProductOptionBottomSheet({super.key, required this.optionGroups});

  @override
  ConsumerState<ProductOptionBottomSheet> createState() =>
      _ProductOptionBottomSheetState();
}

class _ProductOptionBottomSheetState
    extends ConsumerState<ProductOptionBottomSheet> {
  final Map<String, String?> selectedOptions = {}; // groupName → selected value

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
              ElevatedButton(
                onPressed: allSelected
                    ? () {
                  final summary = selectedOptions.entries
                      .map((e) => '${e.key}: ${e.value}')
                      .join(', ');
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('선택: $summary')),
                  );
                  // TODO: SKU 매칭 추가
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('구매하기'),
              ),
            ],
          ),
        );
      },
    );
  }
}
