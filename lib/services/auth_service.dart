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
      body: jsonEncode({'cpf': cpf, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Salva o token ou user
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(data));

      return data;
    } else {
      // Tenta extrair o campo "message" do JSON retornado
      try {
        final errorData = jsonDecode(response.body);
        if (errorData is Map && errorData.containsKey('message')) {
          throw Exception(errorData['message']);
        } else {
          throw Exception('Erro no login.');
        }
      } catch (_) {
        throw Exception('Erro no login.');
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      return jsonDecode(userString);
    }
    return null;
  }
}
