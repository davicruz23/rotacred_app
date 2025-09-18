import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/model/charging.dart';
import '../env/environment.dart';

class ChargingService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<void> sendCharging({
    required String description,
    required String date,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/charging'),
      headers: {'Content-Type': 'application/json'},
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
    final response = await http.get(Uri.parse('$baseUrl/charging/all'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('retornou isso: $data');
      if (data == null) return [];

      return (data as List)
          .map((e) => Charging.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar carregamentos: ${response.statusCode}');
    }
  }

  Future<Charging> getChargingById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Charging.fromJson(data);
    } else {
      throw Exception("Erro ao carregar carregamento $id");
    }
  }
}
