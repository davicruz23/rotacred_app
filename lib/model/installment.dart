import 'sale.dart';

class Installment {
  final int? id;
  final Sale? sale;
  final DateTime dueDate;
  final double amount;
  final bool paid;

  Installment({
    this.id,
    this.sale,
    required this.dueDate,
    required this.amount,
    this.paid = false,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    return Installment(
      id: json['id'],
      sale: json['sale'] != null ? Sale.fromJson(json['sale']) : null,
      dueDate: DateTime.parse(json['dueDate']),
      amount: (json['amount'] != null) ? json['amount'].toDouble() : 0.0,
      paid: json['paid'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sale != null) 'sale': sale!.toJson(),
      'dueDate': dueDate.toIso8601String(),
      'amount': amount,
      'paid': paid,
    };
  }
}
