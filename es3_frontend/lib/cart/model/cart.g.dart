// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      cartItemId: (json['cartItemId'] as num).toInt(),
      skuId: (json['skuId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      productTitle: json['productTitle'] as String,
      optionSummary: json['optionSummary'] as String,
      storeName: json['storeName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      additionalPrice: (json['additionalPrice'] as num).toDouble(),
      discount: (json['discount'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'cartItemId': instance.cartItemId,
      'skuId': instance.skuId,
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'optionSummary': instance.optionSummary,
      'storeName': instance.storeName,
      'quantity': instance.quantity,
      'price': instance.price,
      'additionalPrice': instance.additionalPrice,
      'discount': instance.discount,
      'imageUrl': instance.imageUrl,
    };
