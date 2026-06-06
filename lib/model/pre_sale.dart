import 'package:intl/intl.dart';
import 'pre_sale_item.dart';
import 'client.dart';
import 'dto/seller_dto.dart';

class PreSale {
  final int? id;
  final DateTime preSaleDate;
  final SellerDTO seller;
  final Client client;
  final List<PreSaleItem> items;
  final String? inspector;
  final String? status;
  final int? chargingId;
  final double? totalPreSale;
  final String uuidPreSale;

  PreSale({
    this.id,
    required this.preSaleDate,
    required this.seller,
    required this.client,
    required this.items,
    this.inspector,
    this.status,
    this.chargingId,
    this.totalPreSale,
    required this.uuidPreSale,
  });

  factory PreSale.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;

    try {
      parsedDate = DateTime.parse(json['preSaleDate']);
    } catch (_) {
      parsedDate = DateFormat('dd/MM/yyyy').parse(json['preSaleDate']);
    }

    return PreSale(
      id: json['id'],
      preSaleDate: parsedDate,
      seller: SellerDTO.fromJson(json['seller']),
      client: Client.fromJson(json['client']),
      items: (json['items'] as List<dynamic>)
          .map((i) => PreSaleItem.fromJson(i))
          .toList(),
      inspector: json['inspector'],
      status: json['status'],
      chargingId: json['chargingId'],
      totalPreSale: json['totalPreSale'],
      uuidPreSale: json['uuidPreSale'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final bool existingClient = client.id != null;

    return {
      'id': id ?? 0,
      'clientId': existingClient ? client.id : null,
      'preSaleDate': preSaleDate.toIso8601String(),
      'sellerId': seller.idSeller,
      'client': existingClient ? null : client.toJson(),
      'chargingId': chargingId,
      'products': items
          .map((i) => {'productId': i.productId, 'quantity': i.quantity})
          .toList(),
      'uuidPreSale': uuidPreSale,
    };
  }
}
