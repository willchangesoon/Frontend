class Product {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final String? discount;
  final double rating;

  Product({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    this.discount,
    required this.rating,
  });
}