import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env/environment.dart';
import 'auth_service.dart';

class CepService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<Map<String, dynamic>> buscarPorCep(String cep) async {
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('$baseUrl/api/cep/$cep'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data as Map<String, dynamic>;
    } else {
      throw Exception(
        'Erro ao buscar CEP ($cep): ${response.statusCode}',
      );
    }
  }
}
