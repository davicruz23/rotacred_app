import 'pre_sale_item.dart';
import 'client.dart';
import 'dto/seller_dto.dart';

class PreSale {
  final int? id;
  final DateTime preSaleDate;
  final SellerDTO seller;
  final Client client;
  final List<PreSaleItem> items;
  final String? inspector; // <-- agora opcional
  final String? status; // <-- agora opcional
  final int? chargingId;

  PreSale({
    this.id,
    required this.preSaleDate,
    required this.seller,
    required this.client,
    required this.items,
    this.inspector, // não obrigatório
    this.status, // não obrigatório
    this.chargingId,
  });

  factory PreSale.fromJson(Map<String, dynamic> json) {
    return PreSale(
      id: json['id'],
      preSaleDate: DateTime.parse(json['preSaleDate']),
      seller: SellerDTO.fromJson(json['seller']),
      client: Client.fromJson(json['client']),
      items: (json['items'] as List<dynamic>)
          .map((i) => PreSaleItem.fromJson(i))
          .toList(),
      inspector: json['inspector'], // pode vir null
      status: json['status'], // pode vir null
      chargingId: json['chargingId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'preSaleDate': preSaleDate.toIso8601String(),
      'sellerId': seller.idSeller,
      'client': client.toJson(),
      'chargingId': chargingId,
      'products': items
          .map((i) => {'productId': i.productId, 'quantity': i.quantity})
          .toList(),
      // inspector e status não vão no POST
    };
  }
}
