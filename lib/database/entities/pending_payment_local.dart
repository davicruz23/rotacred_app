import 'package:isar/isar.dart';

part 'pending_payment_local.g.dart';

@collection
class PendingPayment {
  Id id = Isar.autoIncrement;

  late int collectorId;
  late int installmentId;

  double? amount;
  String? paymentMethod;

  bool requiresPaySale = false; // 🔥 controla se precisa do PAY
  bool paySent = false; // 🔥 controla se o PAY já foi feito

  double? latitude;
  double? longitude;
  String? note;
  DateTime? newDueDate;

  late DateTime createdAt;
}
