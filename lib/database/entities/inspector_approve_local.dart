import 'package:isar/isar.dart';

part 'inspector_approve_local.g.dart';

@collection
class InspectorApproveLocal {
  Id id = Isar.autoIncrement;

  late int preSaleId;
  late int inspectorId;

  late String paymentMethod;
  late int installments;

  double? cashPaid;
  double? latitude;
  double? longitude;

  late DateTime createdAt;
}