import 'client.dart';
import 'pre_sale_item.dart';

class PreSale {
  final int? id;
  final DateTime preSaleDate;
  final int sellerId;
  final Client client;
  final List<PreSaleItem> products;
  final int chargingId;

  PreSale({
    this.id,
    required this.preSaleDate,
    required this.sellerId,
    required this.client,
    required this.products,
    required this.chargingId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'preSaleDate': preSaleDate.toIso8601String(),
      'sellerId': sellerId,
      'client': client.toJson(),
      'products': products.map((e) => e.toJson()).toList(),
      'chargingId': chargingId,
    };
  }

  factory PreSale.fromJson(Map<String, dynamic> json) {
    return PreSale(
      id: json['id'] ?? 0, // garante que não vai ser null
      preSaleDate: DateTime.parse(json['preSaleDate']),
      sellerId: json['seller']?['id'] ?? 0, // agora pega do objeto seller
      client: Client.fromJson(json['client']),
      products: (json['products'] ?? json['items'] ?? [])
          .map<PreSaleItem>((e) => PreSaleItem.fromJson(e))
          .toList(),
      chargingId: json['chargingId'] ?? 0,
    );
  }
}
