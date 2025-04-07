import 'package:es3_frontend/products/model/product.dart';
import 'package:es3_frontend/products/model/product_option.dart';
import 'package:es3_frontend/products/model/product_option_group_model.dart';
import 'package:es3_frontend/products/model/product_sku_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel extends Product {
  final String storeLogoImg;
  final String description;
  final List<String> additionalImages;

  final List<ProductOptionGroupModel> optionGroups;
  final List<ProductSKUModel> skuList;

  ProductDetailModel({
    required super.id,
    required super.imageUrl,
    required super.title,
    required super.storeName,
    required super.price,
    super.discount,
    super.rating,
    required this.storeLogoImg,
    required this.description,
    required this.additionalImages,
    required this.optionGroups,
    required this.skuList,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}