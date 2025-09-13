class Address {
  final int? id;
  final String state;
  final String city;
  final String street;
  final String number;
  final String zipCode;
  final String? complement;

  Address({
    this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
    this.complement,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      state: json['state'],
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipCode: json['zipCode'],
      complement: json['complement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'state': state,
      'city': city,
      'street': street,
      'number': number,
      'zipCode': zipCode,
      if (complement != null) 'complement': complement,
    };
  }
}
