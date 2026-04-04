import 'package:intl/intl.dart';
import 'package:rotacred_app/database/entities/sales_collector_local.dart';

class SaleCollectorDTO {
  final int id;
  final DateTime saleDate;
  final ClientDTO client;
  final List<ProductSaleDTO> products;
  final List<InstallmentDTO> installments;
  final double? paidAmount;
  final double? latitude;
  final double? longitude;

  SaleCollectorDTO({
    required this.id,
    required this.saleDate,
    required this.client,
    required this.products,
    required this.installments,
    required this.paidAmount,
    this.latitude,
    this.longitude,
  });

  factory SaleCollectorDTO.fromJson(Map<String, dynamic> json) {
    DateTime parsedSaleDate;

    try {
      parsedSaleDate = DateTime.parse(json['saleDate']);
    } catch (_) {
      parsedSaleDate = DateFormat('dd/MM/yyyy').parse(json['saleDate']);
    }

    return SaleCollectorDTO(
      id: json['id'],
      saleDate: parsedSaleDate,
      client: ClientDTO.fromJson(json['client']),
      products: (json['products'] as List)
          .map((e) => ProductSaleDTO.fromJson(e))
          .toList(),
      installments: (json['installments'] as List)
          .map((e) => InstallmentDTO.fromJson(e))
          .toList(),
      paidAmount: json[''],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // 🔥 ADICIONADO: conversão do Isar → DTO
  factory SaleCollectorDTO.fromLocal(SaleCollectorLocal local) {
    DateTime parsedSaleDate;

    try {
      parsedSaleDate = DateTime.parse(local.saleDate);
    } catch (_) {
      parsedSaleDate = DateFormat('dd/MM/yyyy').parse(local.saleDate);
    }

    return SaleCollectorDTO(
      id: local.saleId,
      saleDate: parsedSaleDate,

      client: ClientDTO(
        name: local.client.name,
        cpf: local.client.cpf,
        phone: local.client.phone,
        address: AddressDTO(
          id: local.client.address.id,
          city: local.client.address.city,
          street: local.client.address.street,
          number: local.client.address.number,
          zipCode: local.client.address.zipCode,
          complement: local.client.address.complement ?? '',
        ),
      ),

      products: local.products
          .map(
            (p) => ProductSaleDTO(
              id: p.id,
              nameProduct: p.nameProduct,
              quantity: p.quantity,
            ),
          )
          .toList(),

      installments: local.installments
          .map(
            (i) => InstallmentDTO(
              id: i.id,
              dueDate: (() {
                try {
                  return DateTime.parse(i.dueDate);
                } catch (_) {
                  return DateFormat('dd/MM/yyyy').parse(i.dueDate);
                }
              })(),
              amount: i.amount,
              paid: i.paid,
            ),
          )
          .toList(),

      paidAmount: null, // não existe no local ainda
      latitude: local.latitude,
      longitude: local.longitude,
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
  final int quantity;

  ProductSaleDTO({
    required this.id,
    required this.nameProduct,
    required this.quantity,
  });

  factory ProductSaleDTO.fromJson(Map<String, dynamic> json) {
    return ProductSaleDTO(
      id: json['id'],
      nameProduct: json['nameProduct'],
      quantity: json['quantity'],
    );
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
    DateTime parsedDueDate;

    try {
      parsedDueDate = DateTime.parse(json['dueDate']);
    } catch (_) {
      parsedDueDate = DateFormat('dd/MM/yyyy').parse(json['dueDate']);
    }

    return InstallmentDTO(
      id: json['id'],
      dueDate: parsedDueDate,
      amount: (json['amount'] as num).toDouble(),
      paid: json['paid'],
    );
  }
}
