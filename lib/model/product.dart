class Product {
  final int id;
  final String name;
  final String brand;
  final int amount;
  final double value;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.amount,
    required this.value,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      amount: json['amount'],
      value: (json['value'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'amount': amount,
      'value': value,
    };
  }
}
