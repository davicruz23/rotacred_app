import 'package:isar/isar.dart';
import 'address_local.dart';

part 'client_local.g.dart';

@collection
class ClientLocal {

  Id id = Isar.autoIncrement;

  int? serverId;

  late String name;
  late String cpf;
  late String phone;

  AddressLocal? address;

  bool synced = false;

}