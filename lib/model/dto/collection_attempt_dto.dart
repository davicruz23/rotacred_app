class CollectionAttemptDTO {
  final int collectorId;
  final int installmentId;
  final double? amount;
  final String? paymentType;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? newDueDate;

  CollectionAttemptDTO({
    required this.collectorId,
    required this.installmentId,
    this.amount,
    this.paymentType,
    this.latitude,
    this.longitude,
    this.note,
    this.newDueDate,
  });

  Map<String, dynamic> toJson() => {
        'collectorId': collectorId,
        'installmentId': installmentId,
        'amount': amount,
        'paymentType': paymentType,
        'latitude': latitude,
        'longitude': longitude,
        'note': note,
        'newDueDate': newDueDate,
      };

  factory CollectionAttemptDTO.fromJson(Map<String, dynamic> json) {
    return CollectionAttemptDTO(
      collectorId: json['collectorId'],
      installmentId: json['installmentId'],
      amount: json['amount']?.toDouble(),
      paymentType: json['paymentType'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      note: json['note'],
      newDueDate: json['newDueDate'],
    );
  }
}
