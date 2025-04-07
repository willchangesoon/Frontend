import 'package:json_annotation/json_annotation.dart';

part 'product_option.g.dart';

@JsonSerializable()
class ProductOptionModel {
  final int optionId;
  final String value;

  ProductOptionModel({
    required this.optionId,
    required this.value,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);
}
