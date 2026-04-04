import 'pre_sale.dart';
import 'collector.dart';
import 'installment.dart';

class Sale {
  final int? id;
  final String numberSale;
  final DateTime saleDate;
  final PreSale preSale;
  final String paymentMethod; // simplificado como String
  final int installments;
  final double? total;
  final Collector? collector;
  final List<Installment> installmentsEntities;

  Sale({
    this.id,
    required this.numberSale,
    required this.saleDate,
    required this.preSale,
    required this.paymentMethod,
    required this.installments,
    this.total,
    this.collector,
    required this.installmentsEntities,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      numberSale: json['numberSale'],
      saleDate: DateTime.parse(json['saleDate']),
      preSale: PreSale.fromJson(json['preSale']),
      paymentMethod: json['paymentMethod'],
      installments: json['installments'],
      total: (json['total'] != null) ? json['total'].toDouble() : null,
      collector: json['collector'] != null ? Collector.fromJson(json['collector']) : null,
      installmentsEntities: json['installmentsEntities'] != null
          ? (json['installmentsEntities'] as List)
              .map((e) => Installment.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'numberSale': numberSale,
      'saleDate': saleDate.toIso8601String(),
      'preSale': preSale.toJson(),
      'paymentMethod': paymentMethod,
      'installments': installments,
      if (total != null) 'total': total,
      if (collector != null) 'collector': collector!.toJson(),
      'installmentsEntities': installmentsEntities.map((e) => e.toJson()).toList(),
    };
  }
}
