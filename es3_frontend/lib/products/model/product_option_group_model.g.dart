// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionGroupModel _$ProductOptionGroupModelFromJson(
        Map<String, dynamic> json) =>
    ProductOptionGroupModel(
      groupName: json['groupName'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => ProductOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductOptionGroupModelToJson(
        ProductOptionGroupModel instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'options': instance.options,
    };
