// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSKUModel _$ProductSKUModelFromJson(Map<String, dynamic> json) =>
    ProductSKUModel(
      skuId: (json['skuId'] as num).toInt(),
      optionValueList: (json['optionValueList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      quantity: (json['quantity'] as num).toInt(),
      additionalPrice: (json['additionalPrice'] as num).toInt(),
    );

Map<String, dynamic> _$ProductSKUModelToJson(ProductSKUModel instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'optionValueList': instance.optionValueList,
      'quantity': instance.quantity,
      'additionalPrice': instance.additionalPrice,
    };
