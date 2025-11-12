import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../env/environment.dart';
import '../model/user.dart';

class LoginException implements Exception {
  final String message;
  LoginException(this.message);

  @override
  String toString() => message; // retorna apenas a mensagem limpa
}

class AuthService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<User> login(String cpf, String password) async {
    print("🔐 chamando login...");

    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'cpf': cpf, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      print("✅ Login OK: $data");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // 🎯 Decodificando payload
      final payloadBase64 = token.split('.')[1];
      final normalized = base64.normalize(payloadBase64);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)));

      print("➡️ Payload token: $payload");

      final user = User(
        id: payload['id'],
        cpf: payload['sub'],
        name: payload['nome'],
        position: payload['role'], // ⚡ manter ROLE_ para evitar 403
      );

      print('usuario: ${user.position}');

      return user;
    } else {
      throw LoginException("Usuário ou senha incorretos!");
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
