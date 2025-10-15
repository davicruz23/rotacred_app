class InspectorHistoryPreSaleDto {
  final int id;
  final String preSaleDate;
  final String status;
  final double totalPreSale;
  final String clientName;

  InspectorHistoryPreSaleDto({
    required this.id,
    required this.preSaleDate,
    required this.status,
    required this.totalPreSale,
    required this.clientName,
  });

  factory InspectorHistoryPreSaleDto.fromJson(Map<String, dynamic> json) {
    return InspectorHistoryPreSaleDto(
      id: json['id'],
      preSaleDate: json['preSaleDate'] ?? '',
      status: json['status'] ?? '',
      totalPreSale: (json['totalPreSale'] ?? 0).toDouble(),
      clientName: json['client']?['name'] ?? '—',
    );
  }
}
