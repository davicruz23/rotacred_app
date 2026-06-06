import 'address.dart';

class Client {
  final int? id;
  final String name;
  final String cpf;
  final String phone;
  final Address address;

  Client({
    this.id,
    required this.name,
    required this.cpf,
    required this.phone,
    required this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'] ?? '',
      cpf: json['cpf'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(
              state: '',
              city: '',
              street: '',
              number: '',
              zipCode: '',
              complement: '',
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cpf': cpf,
      'phone': phone,
      'address': address.toJson(),
    };
  }
}
