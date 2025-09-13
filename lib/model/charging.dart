import 'charging_item.dart';
import 'user.dart';

class Charging {
  final int? id;
  final String? description;
  final DateTime? date;
  final User? user;
  final List<ChargingItem> items;

  Charging({
    this.id,
    this.description,
    this.date,
    this.user,
    required this.items,
  });

  factory Charging.fromJson(Map<String, dynamic> json) {
  return Charging(
    id: json['id'],
    description: json['description'], // null seguro
    date: json['data'] != null? DateTime.parse(json['data']).toLocal() : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    items: json['items'] != null
        ? (json['items'] as List)
            .map((e) => ChargingItem.fromJson(e))
            .toList()
        : [],
  );
}

Map<String, dynamic> toJson() {
  return {
    if (id != null) 'id': id,
    if (description != null) 'description': description,
    if (date != null) 'created_at': date!.toIso8601String(),
    if (user != null) 'user': user!.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
  };
}

}
