class InstallmentDTO {
  final int id;
  final DateTime dueDate;
  final double amount;
  final bool paid;

  InstallmentDTO({
    required this.id,
    required this.dueDate,
    required this.amount,
    required this.paid,
  });

  factory InstallmentDTO.fromJson(Map<String, dynamic> json) {
    return InstallmentDTO(
      id: json['id'],
      dueDate: DateTime.parse(json['dueDate']),
      amount: (json['amount'] as num).toDouble(),
      paid: json['paid'],
    );
  }
}
