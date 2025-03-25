// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      storeName: json['storeName'] as String,
      price: (json['price'] as num).toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'storeName': instance.storeName,
      'price': instance.price,
      'discount': instance.discount,
      'rating': instance.rating,
    };
