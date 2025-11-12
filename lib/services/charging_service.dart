import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/model/charging.dart';
import '../env/environment.dart';
import 'auth_service.dart'; // Importa AuthService para pegar o token

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
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/charging/current'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) return [];

      return (data as List)
          .map((e) => Charging.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar carregamentos: ${response.statusCode}');
    }
  }

  Future<Charging> getChargingById(int id) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse("$baseUrl/$id"),
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
