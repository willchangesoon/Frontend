import 'package:es3_frontend/products/screen/s_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/category_tree_builder.dart';
import '../repository/category_repository.dart';

final categoryFutureProvider = FutureProvider<List<CategoryNode>>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  final categories = await repo.getCategories();
  return buildCategoryTree(categories);
});

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  int selectedUpperIndex = 0;

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(categoryFutureProvider);
    return asyncData.when(
      data: (tree) {
        return Row(
          children: [
            Container(
              width: 150.0,
              color: Colors.grey.shade300,
              child: ListView.builder(
                itemCount: tree.length,
                itemBuilder: (context, index) {
                  final item = tree[index];
                  return Material(
                    child: ListTile(
                      title: Text(item.category.name),
                      tileColor: index == selectedUpperIndex
                          ? Colors.white
                          : Colors.grey.shade300,
                      onTap: () {
                        setState(() {
                          selectedUpperIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tree[selectedUpperIndex].children.length,
                itemBuilder: (context, index) {
                  final lower = tree[selectedUpperIndex].children[index];
                  return ListTile(
                    title: Text(lower.category.name),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey.shade600),
                    onTap: () {
                      context.pushNamed(
                        ProductListScreen.routeName,
                        pathParameters: {'cid': lower.category.id.toString()},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('에러: $e')),
    );
  }
}
