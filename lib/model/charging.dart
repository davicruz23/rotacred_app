import 'charging_item.dart';

class Charging {
  final int id;
  final String chargingDate;
  final String userName;
  final String description;
  final String data;
  final List<ChargingItem> chargingItems;

  Charging({
    required this.id,
    required this.chargingDate,
    required this.userName,
    required this.description,
    required this.data,
    required this.chargingItems,
  });

  factory Charging.fromJson(Map<String, dynamic> json) {
    return Charging(
      id: json['id'] ?? 0,
      chargingDate: json['chargingDate'] ?? '',
      userName: json['userName'] ?? '',
      description: json['description'] ?? '',
      data: json['data'] ?? '',
      chargingItems: (json['chargingItems'] as List<dynamic>?)
              ?.map((e) => ChargingItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  factory Charging.empty() {
    return Charging(
      id: 0,
      chargingDate: '',
      userName: '',
      description: '',
      data: '',
      chargingItems: [],
    );
  }
}

