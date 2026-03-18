import 'package:isar/isar.dart';

part 'collector_local.g.dart';

@collection
class CollectorLocal {

  Id id = Isar.autoIncrement;

  int? serverId;

  @Index(unique: true)
  late int userId;
}