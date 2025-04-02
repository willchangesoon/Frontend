import 'category.dart';

class CategoryNode {
  final CategoryModel category;
  final List<CategoryNode> children;

  CategoryNode({
    required this.category,
    List<CategoryNode>? children,
  }) : children = children ?? [];
}
List<CategoryNode> buildCategoryTree(List<CategoryModel> categories) {
  final Map<int, CategoryNode> nodeMap = {
    for (final c in categories) c.id: CategoryNode(category: c)
  };

  final List<CategoryNode> roots = [];

  for (final node in nodeMap.values) {
    final parentId = node.category.parentsId;
    if (parentId == null) {
      roots.add(node); // 대분류
    } else {
      final parent = nodeMap[parentId];
      parent?.children.add(node); // ✨ 여기서 직접 children에 추가
    }
  }

  return roots;
}