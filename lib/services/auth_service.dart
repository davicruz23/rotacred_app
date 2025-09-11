import 'dart:convert';
import 'package:http/http.dart' as http;
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
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro no login: ${response.body}');
    }
  }
}
