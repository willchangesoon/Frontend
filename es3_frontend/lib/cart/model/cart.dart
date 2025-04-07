import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartItem {
  final int cartItemId;
  final int skuId;
  final int productId;
  final String productTitle;
  final String optionSummary;
  final String storeName;
  int quantity;
  final double price;
  final double additionalPrice;
  final int discount;
  final String imageUrl;

  CartItem({
    required this.cartItemId,
    required this.skuId,
    required this.productId,
    required this.productTitle,
    required this.optionSummary,
    required this.storeName,
    required this.quantity,
    required this.price,
    required this.additionalPrice,
    required this.discount,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  CartItem copyWith({
    int? cartItemId,
    int? skuId,
    int? productId,
    String? productTitle,
    String? storeName,
    String? optionSummary,
    int? quantity,
    double? price,
    double? additionalPrice,
    String? imageUrl,
    int? discount,
  }) {
    return CartItem(
      cartItemId: cartItemId ?? this.cartItemId,
      skuId: skuId ?? this.skuId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      storeName: storeName ?? this.storeName,
      optionSummary: optionSummary ?? this.optionSummary,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      additionalPrice: additionalPrice ?? this.additionalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
    );
  }
}
