class ChargingItem {
  final int id;
  final int productId;
  final int chargingId;
  final int quantity;
  final String nameProduct;
  final String brand;

  ChargingItem({
    required this.id,
    required this.productId,
    required this.chargingId,
    required this.quantity,
    required this.nameProduct,
    required this.brand
  });

  factory ChargingItem.fromJson(Map<String, dynamic> json) {
    return ChargingItem(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      chargingId: json['chargingId'] ?? 0,
      quantity: json['quantity'] ?? 0,
      nameProduct: json['nameProduct'] ?? "",
      brand: json['brand'] ?? ""
    );
  }
}
