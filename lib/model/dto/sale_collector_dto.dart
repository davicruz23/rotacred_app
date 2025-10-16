import 'dart:ffi';

class SaleCollectorDTO {
  final int id;
  final DateTime saleDate;
  final ClientDTO client;
  final List<ProductSaleDTO> products;
  final List<InstallmentDTO> installments;
  final double? latitude;
  final double? longitude;

  SaleCollectorDTO({
    required this.id,
    required this.saleDate,
    required this.client,
    required this.products,
    required this.installments,
    this.latitude,
    this.longitude
  });

  factory SaleCollectorDTO.fromJson(Map<String, dynamic> json) {
    return SaleCollectorDTO(
      id: json['id'],
      saleDate: DateTime.parse(json['saleDate']),
      client: ClientDTO.fromJson(json['client']),
      products: (json['products'] as List)
          .map((e) => ProductSaleDTO.fromJson(e))
          .toList(),
      installments: (json['installments'] as List)
          .map((e) => InstallmentDTO.fromJson(e))
          .toList(),
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class ClientDTO {
  final String name;
  final String cpf;
  final String phone;
  final AddressDTO address;

  ClientDTO({
    required this.name,
    required this.cpf,
    required this.phone,
    required this.address,
  });

  factory ClientDTO.fromJson(Map<String, dynamic> json) {
    return ClientDTO(
      name: json['name'],
      cpf: json['cpf'],
      phone: json['phone'],
      address: AddressDTO.fromJson(json['address']),
    );
  }
}

class AddressDTO {
  final int id;
  final String city;
  final String street;
  final String number;
  final String zipCode;
  final String complement;

  AddressDTO({
    required this.id,
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    required this.complement,
  });

  factory AddressDTO.fromJson(Map<String, dynamic> json) {
    return AddressDTO(
      id: json['id'],
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipCode: json['zipCode'],
      complement: json['complement'],
    );
  }
}

class ProductSaleDTO {
  final int id;
  final String nameProduct;

  ProductSaleDTO({required this.id, required this.nameProduct});

  factory ProductSaleDTO.fromJson(Map<String, dynamic> json) {
    return ProductSaleDTO(id: json['id'], nameProduct: json['nameProduct']);
  }
}

class InstallmentDTO {
  final int id;
  final DateTime dueDate;
  final double amount;
  final bool paid;

  InstallmentDTO({
    required this.id,
    required this.dueDate,
    required this.amount,
    required this.paid,
  });

  factory InstallmentDTO.fromJson(Map<String, dynamic> json) {
    return InstallmentDTO(
      id: json['id'],
      dueDate: DateTime.parse(json['dueDate']),
      amount: (json['amount'] as num).toDouble(),
      paid: json['paid'],
    );
  }
}
