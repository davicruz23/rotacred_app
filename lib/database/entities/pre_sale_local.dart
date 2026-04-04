import 'package:isar/isar.dart';
import 'address_local.dart';

part 'pre_sale_local.g.dart';

@collection
class PreSaleLocal {

  Id id = Isar.autoIncrement;

  int? serverId;

  late String localUuid;

  late DateTime preSaleDate;

  late int sellerId;
  late String sellerName;

  late int clientId;
  late String clientName;
  late String clientCpf;
  late String clientPhone;

  AddressLocal? clientAddress;

  String? inspector;
  String? status;

  int? chargingId;
  double? totalPreSale;

  bool synced = false;
}