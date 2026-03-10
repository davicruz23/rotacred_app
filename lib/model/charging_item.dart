import 'package:isar/isar.dart';

part 'charging_item.g.dart';

@collection
class ChargingItem {

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int serverId;
  late int productId;
  late int chargingId;
  late int quantity;
  late String nameProduct;
  late String brand;
  late double priceProduct;

  ChargingItem();

  factory ChargingItem.fromJson(Map<String, dynamic> json) {
    final item = ChargingItem();

    item.serverId = json['id'] ?? 0;
    item.productId = json['productId'] ?? 0;
    item.chargingId = json['chargingId'] ?? 0;
    item.quantity = json['quantity'] ?? 0;
    item.nameProduct = json['nameProduct'] ?? "";
    item.brand = json['brand'] ?? "";
    item.priceProduct = (json['priceProduct'] ?? 0).toDouble();

    return item;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": serverId,
      "productId": productId,
      "chargingId": chargingId,
      "quantity": quantity,
      "nameProduct": nameProduct,
      "brand": brand,
      "priceProduct": priceProduct
    };
  }
}