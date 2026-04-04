import 'package:isar/isar.dart';

part 'sale_return_local.g.dart';

@collection
class SaleReturnLocal {
  Id id = Isar.autoIncrement;

  late int saleId;

  late List<String> itemsJson;

  late int status;
  String? description;

  late DateTime createdAt;
}