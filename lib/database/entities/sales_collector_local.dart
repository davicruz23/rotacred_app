import 'package:isar/isar.dart';

part 'sales_collector_local.g.dart';

@collection
class SaleCollectorLocal {
  Id id = Isar.autoIncrement;

  late int saleId;
  late String city;
  late String saleDate;

  late ClientLocall client;

  late List<ProductLocall> products;
  late List<InstallmentLocall> installments;

  double? latitude;
  double? longitude;

  // ✅ construtor vazio
  SaleCollectorLocal();

  factory SaleCollectorLocal.fromJson(String city, Map<String, dynamic> json) {
    return SaleCollectorLocal()
      ..saleId = json['id']
      ..city = city
      ..saleDate = json['saleDate']
      ..client = ClientLocall.fromJson(json['client'])
      ..products = (json['products'] as List)
          .map((e) => ProductLocall.fromJson(e))
          .toList()
      ..installments = (json['installments'] as List)
          .map((e) => InstallmentLocall.fromJson(e))
          .toList()
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble();
  }
}

@embedded
class ClientLocall {
  late String name;
  late String cpf;
  late String phone;

  late AddressLocall address;

  // ✅ construtor vazio
  ClientLocall();

  factory ClientLocall.fromJson(Map<String, dynamic> json) {
    return ClientLocall()
      ..name = json['name']
      ..cpf = json['cpf']
      ..phone = json['phone']
      ..address = AddressLocall.fromJson(json['address']);
  }
}

@embedded
class AddressLocall {
  late int id;
  late String city;
  late String street;
  late String number;
  late String zipCode;
  String? complement;

  // ✅ construtor vazio
  AddressLocall();

  factory AddressLocall.fromJson(Map<String, dynamic> json) {
    return AddressLocall()
      ..id = json['id']
      ..city = json['city']
      ..street = json['street']
      ..number = json['number']
      ..zipCode = json['zipCode']
      ..complement = json['complement'];
  }
}

@embedded
class ProductLocall {
  late int id;
  late String nameProduct;
  late int quantity;
  double? price;

  // ✅ construtor vazio
  ProductLocall();

  factory ProductLocall.fromJson(Map<String, dynamic> json) {
    return ProductLocall()
      ..id = json['id']
      ..nameProduct = json['nameProduct']
      ..quantity = json['quantity']
      ..price = (json['price'] as num?)?.toDouble();
  }
}

@embedded
class InstallmentLocall {
  late int id;
  late String dueDate;
  late double amount;
  late bool paid;
  late String status;

  bool? isValid;
  double? attemptLatitude;
  double? attemptLongitude;

  // ✅ construtor vazio
  InstallmentLocall();

  factory InstallmentLocall.fromJson(Map<String, dynamic> json) {
    return InstallmentLocall()
      ..id = json['id']
      ..dueDate = json['dueDate']
      ..amount = (json['amount'] as num).toDouble()
      ..paid = json['paid']
      ..status = json['status']
      ..isValid = json['isValid']
      ..attemptLatitude = (json['attemptLatitude'] as num?)?.toDouble()
      ..attemptLongitude = (json['attemptLongitude'] as num?)?.toDouble();
  }
}
