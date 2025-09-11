import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
