class OptionGroup {
  String name;
  List<ProductOption> options;

  OptionGroup({
    required this.name,
    List<ProductOption>? options,
  }) : options = options ?? [];
}

class ProductOption {
  String name;
  String value;
  int stock;
  int extraPrice;

  ProductOption({
    required this.name,
    required this.value,
    required this.stock,
    required this.extraPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'stock': stock,
      'extraPrice': extraPrice,
    };
  }
}
