import 'package:es3_frontend/products/model/product_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_option_group_model.g.dart';

@JsonSerializable()
class ProductOptionGroupModel {
  final String groupName;
  final List<ProductOptionModel> options;

  ProductOptionGroupModel({
    required this.groupName,
    required this.options,
  });

  factory ProductOptionGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionGroupModelFromJson(json);
}
