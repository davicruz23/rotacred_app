import 'package:isar/isar.dart';

part 'pre_sale_item_local.g.dart';

@collection
class PreSaleItemLocal {

  Id id = Isar.autoIncrement;

  late int preSaleLocalId;

  late int productId;
  late String productName;
  late int quantity;
  late double unitPrice;
}