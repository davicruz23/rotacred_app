import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:rotacred_app/model/charging.dart';
import 'package:rotacred_app/model/charging_item.dart';

import '../env/environment.dart';
import '../database/database_service.dart';
import 'auth_service.dart';

class ChargingService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<void> sendCharging({
    required String description,
    required String date,
    required List<Map<String, dynamic>> items,
  }) async {
    final headers = await _getHeaders();

    final response = await http.post(
      Uri.parse('$baseUrl/charging'),
      headers: headers,
      body: jsonEncode({
        'description': description,
        'date': date,
        'items': items,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao enviar carregamento: ${response.body}');
    }
  }

  Future<List<Charging>> getChargings() async {
    try {
      final headers = await _getHeaders();

      final response = await http.get(
        Uri.parse('$baseUrl/charging/current'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data == null) return [];

        final chargings = (data as List)
            .map((e) => Charging.fromJson(e as Map<String, dynamic>))
            .toList();

        final isar = DatabaseService.isar;

        await isar.writeTxn(() async {
          for (final charging in chargings) {
            print("Charging recebido da API: ${charging.serverId}");

            final existing = await isar.chargings
                .filter()
                .serverIdEqualTo(charging.serverId)
                .findFirst();

            if (existing != null) {
              charging.id = existing.id;
            }

            final chargingId = await isar.chargings.put(charging);

            for (final item in charging.chargingItems) {
              item.chargingId = chargingId;

              final existingItem = await isar.chargingItems
                  .filter()
                  .serverIdEqualTo(item.serverId)
                  .findFirst();

              if (existingItem != null) {
                item.id = existingItem.id;
              }

              await isar.chargingItems.put(item);
            }
          }
        });

        print("📦 Carregamentos sincronizados e salvos no banco local");

        return chargings;
      } else {
        throw Exception('Erro ao buscar carregamentos: ${response.statusCode}');
      }
    } catch (e) {
      print("⚠️ Sem internet, carregando carregamentos do banco local");

      final isar = DatabaseService.isar;

      final chargings = await isar.chargings.where().findAll();

      for (final charging in chargings) {
        final items = await isar.chargingItems
            .filter()
            .chargingIdEqualTo(charging.id)
            .findAll();

        charging.chargingItems = items;
      }

      return chargings;
    }
  }

  Future<Charging> getChargingById(int id) async {
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse("$baseUrl/charging/$id"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return Charging.fromJson(data);
    } else {
      throw Exception("Erro ao carregar carregamento $id");
    }
  }
}
