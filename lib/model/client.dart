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
      name: json['name'],
      cpf: json['cpf'],
      phone: json['phone'],
      address: Address.fromJson(json['address']),
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
