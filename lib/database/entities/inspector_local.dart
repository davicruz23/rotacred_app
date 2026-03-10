import 'package:isar/isar.dart';

part 'inspector_local.g.dart';

@collection
class InspectorLocal {

  Id id = Isar.autoIncrement;

  int? serverId;

  @Index(unique: true)
  late int userId;

  late String userName;
}