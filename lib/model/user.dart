import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {

  Id id = Isar.autoIncrement;

  late int serverId;
  late String name;
  late String cpf;
  late String position;
  late String passwordHash;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    final user = User();
    user.serverId = json['id'];
    user.name = json['name'];
    user.cpf = json['cpf'];
    user.position = json['position'];
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': serverId,
      'name': name,
      'cpf': cpf,
      'position': position,
    };
  }
}