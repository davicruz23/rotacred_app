import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:rotacred_app/model/pre_sale.dart';

part 'inspector_pre_sale_local.g.dart';

@collection
class InspectorPreSaleLocal {
  Id id = Isar.autoIncrement;

  late int serverId;
  late int inspectorId;

  late int sellerId;
  late String sellerName;

  late int clientId;
  late String clientName;
  late String clientCpf;
  late String clientPhone;
  late String clientState;
  late String clientCity;
  late String clientStreet;
  late String clientNumber;
  late String clientZipCode;
  late String clientComplement;

  late DateTime preSaleDate;
  double totalPreSale = 0;
  late String status;

  late String itemsJson;
  
  InspectorPreSaleLocal();
  factory InspectorPreSaleLocal.fromPreSale(PreSale preSale, int inspectorId) {
    return InspectorPreSaleLocal()
      ..serverId = preSale.id!
      ..inspectorId = inspectorId
      ..sellerId = preSale.seller.idSeller
      ..sellerName = preSale.seller.nomeSeller
      ..clientId = preSale.client.id!
      ..clientName = preSale.client.name
      ..clientCpf = preSale.client.cpf
      ..clientPhone = preSale.client.phone
      ..clientState = preSale.client.address.state
      ..clientCity = preSale.client.address.city
      ..clientStreet = preSale.client.address.street
      ..clientNumber = preSale.client.address.number
      ..clientZipCode = preSale.client.address.zipCode
      ..clientComplement = preSale.client.address.complement!
      ..preSaleDate = preSale.preSaleDate
      ..totalPreSale = preSale.totalPreSale ?? 0
      ..status = preSale.status ?? 'PENDENTE'
      ..itemsJson = jsonEncode(preSale.items.map((e) => e.toJson()).toList());
  }
}