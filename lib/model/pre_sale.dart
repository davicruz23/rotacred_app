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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'preSaleDate': preSaleDate.toIso8601String(), // mantém ISO no envio
      'sellerId': seller.idSeller,
      'client': client.toJson(),
      'chargingId': chargingId,
      'products': items
          .map((i) => {'productId': i.productId, 'quantity': i.quantity})
          .toList(),
    };
  }
}
