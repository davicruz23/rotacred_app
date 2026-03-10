import 'package:isar/isar.dart';

part 'seller_local.g.dart';

@collection
class SellerLocal {

  Id id = Isar.autoIncrement;

  int? serverId;

  @Index(unique: true)
  late int userId;

  late String userName;

  double totalCommission = 0;
}