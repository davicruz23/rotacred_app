import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../env/environment.dart';
import '../model/user.dart';

class LoginException implements Exception {
  final String message;
  LoginException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<User> login(String cpf, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'cpf': cpf, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      final payloadBase64 = token.split('.')[1];
      final normalized = base64.normalize(payloadBase64);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)));

      final role = payload['role'];

      const allowedRoles = {'ROLE_VENDEDOR', 'ROLE_FISCAL', 'ROLE_COBRADOR'};

      if (!allowedRoles.contains(role)) {
        throw LoginException("Usuário não tem permissão para acessar!");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      final user = User(
        id: payload['id'],
        cpf: payload['sub'],
        name: payload['nome'],
        position: role,
      );

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
