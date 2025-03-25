import 'package:es3_frontend/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product implements IModelWithId {
  final int id;
  final String imageUrl;
  final String title;
  final String storeName;
  final int price;
  final int? discount;
  final double? rating;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.storeName,
    required this.price,
    this.discount,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
