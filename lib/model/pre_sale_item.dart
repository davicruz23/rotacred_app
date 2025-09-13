class PreSaleItem {
  final int? id;
  final int productId;
  final int quantity;

  PreSaleItem({
    this.id,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory PreSaleItem.fromJson(Map<String, dynamic> json) {
    return PreSaleItem(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
