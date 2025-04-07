// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      storeName: json['storeName'] as String,
      price: (json['price'] as num).toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      storeLogoImg: json['storeLogoImg'] as String,
      description: json['description'] as String,
      additionalImages: (json['additionalImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      optionGroups: (json['optionGroups'] as List<dynamic>)
          .map((e) =>
              ProductOptionGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skuList: (json['skuList'] as List<dynamic>)
          .map((e) => ProductSKUModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'storeName': instance.storeName,
      'price': instance.price,
      'discount': instance.discount,
      'rating': instance.rating,
      'storeLogoImg': instance.storeLogoImg,
      'description': instance.description,
      'additionalImages': instance.additionalImages,
      'optionGroups': instance.optionGroups,
      'skuList': instance.skuList,
    };
