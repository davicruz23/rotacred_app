class PreSaleItem {
  final int? id;
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  PreSaleItem({
    this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory PreSaleItem.fromJson(Map<String, dynamic> json) {
    return PreSaleItem(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
    );
  }
}
