class Product {
  final String title;
  final bool visibility;
  final String deliveryType;
  final int mainCategoryId;
  final int subCategoryId;
  final int price;
  final String mainImage;
  final List<String> additionalImages;
  final String description;

  Product({
    required this.title,
    required this.visibility,
    required this.deliveryType,
    required this.mainCategoryId,
    required this.subCategoryId,
    required this.price,
    required this.mainImage,
    required this.additionalImages,
    required this.description,
  });
}
