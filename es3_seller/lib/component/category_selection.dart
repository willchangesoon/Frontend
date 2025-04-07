import 'package:flutter/material.dart';

import '../product/model/category.dart';

class CategorySelection extends StatelessWidget {
  final List<Category> topCategories;
  final List<Category> subCategories;
  final Category? selectedTopCategory;
  final Category? selectedSubCategory;
  final ValueChanged<Category?> onTopCategoryChanged;
  final ValueChanged<Category?> onSubCategoryChanged;

  const CategorySelection({
    Key? key,
    required this.topCategories,
    required this.subCategories,
    required this.selectedTopCategory,
    required this.selectedSubCategory,
    required this.onTopCategoryChanged,
    required this.onSubCategoryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Main Category'),
            DropdownButton<Category>(
              value: selectedTopCategory,
              hint: const Text("main category"),
              items: topCategories.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: onTopCategoryChanged,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subcategory'),
            DropdownButton<Category>(
              value: selectedSubCategory,
              hint: subCategories.isNotEmpty
                  ? const Text("subcategory")
                  : const Text('-'),
              items: subCategories.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: onSubCategoryChanged,
            ),
          ],
        ),
      ],
    );
  }
}
