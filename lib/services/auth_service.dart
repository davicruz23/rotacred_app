import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../env/environment.dart';

class AuthService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<Map<String, dynamic>> login(String cpf, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'cpf': cpf,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Salvar token no dispositivo
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);

      return data;
    } else {
      throw Exception('Erro no login: ${response.body}');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
