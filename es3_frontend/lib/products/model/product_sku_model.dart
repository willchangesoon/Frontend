import 'package:json_annotation/json_annotation.dart';

part 'product_sku_model.g.dart';

@JsonSerializable()
class ProductSKUModel {
  final int skuId;
  final List<String> optionValueList;
  final int quantity;
  final int additionalPrice;

  ProductSKUModel({
    required this.skuId,
    required this.optionValueList,
    required this.quantity,
    required this.additionalPrice,
  });

  factory ProductSKUModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSKUModelFromJson(json);
}
