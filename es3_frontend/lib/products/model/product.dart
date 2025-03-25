class Product {
  final String imageUrl;
  final String title;
  final String storeName;
  final String price;
  final String? discount;
  final double rating;

  Product({
    required this.imageUrl,
    required this.title,
    required this.storeName,
    required this.price,
    this.discount,
    required this.rating,
  });
}