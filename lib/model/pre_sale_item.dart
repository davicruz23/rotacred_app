class PreSaleItem {
  final int? id;
  final int productId;
  final String productName;
  final int quantity;

  PreSaleItem({this.id, required this.productId,required this.productName, required this.quantity});

  Map<String, dynamic> toJson() {
    return {'id': id ?? 0, 'productId': productId, 'productName': productName, 'quantity': quantity};
  }

  factory PreSaleItem.fromJson(Map<String, dynamic> json) {
    return PreSaleItem(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
    );
  }
}
