// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionModel _$ProductOptionModelFromJson(Map<String, dynamic> json) =>
    ProductOptionModel(
      optionId: (json['optionId'] as num).toInt(),
      value: json['value'] as String,
    );

Map<String, dynamic> _$ProductOptionModelToJson(ProductOptionModel instance) =>
    <String, dynamic>{
      'optionId': instance.optionId,
      'value': instance.value,
    };
