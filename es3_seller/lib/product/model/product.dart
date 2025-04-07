import 'package:es3_seller/product/model/product_option.dart';

class Product {
  final String title;
  final bool visibility;
  final String deliveryType;
  final int categoryId;
  final int price;
  final String mainImage;
  final List<String> additionalImages;
  final String description;
  final List<ProductOption> productOptionList;

  Product({
    required this.title,
    required this.visibility,
    required this.deliveryType,
    required this.categoryId,
    required this.price,
    required this.mainImage,
    required this.additionalImages,
    required this.description,
    required this.productOptionList,
  });
}
