import 'package:isar/isar.dart';
import 'charging_item.dart';

part 'charging.g.dart';

@collection
class Charging {
  Id id = Isar.autoIncrement;

  @Index(unique: true) // 👈 importante
  late int serverId;

  late String chargingDate;
  late String userName;
  late String description;
  late String data;

  @ignore
  List<ChargingItem> chargingItems = [];

  Charging();

  factory Charging.fromJson(Map<String, dynamic> json) {
    final charging = Charging();

    charging.serverId = json['id'] ?? 0;
    charging.chargingDate = json['chargingDate'] ?? '';
    charging.userName = json['userName'] ?? '';
    charging.description = json['description'] ?? '';
    charging.data = json['data'] ?? '';

    charging.chargingItems =
        (json['chargingItems'] as List<dynamic>?)
            ?.map((e) => ChargingItem.fromJson(e))
            .toList() ??
        [];

    return charging;
  }

  factory Charging.empty() {
    final charging = Charging();

    charging.serverId = 0;
    charging.chargingDate = '';
    charging.userName = '';
    charging.description = '';
    charging.data = '';
    charging.chargingItems = [];

    return charging;
  }
}
