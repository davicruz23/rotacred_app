class User {
  final int id;
  final String name;
  final String cpf;
  final String position;

  User({
    required this.id,
    required this.name,
    required this.cpf,
    required this.position,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'position': position,
    };
  }
}
