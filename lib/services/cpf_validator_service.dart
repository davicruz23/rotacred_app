import 'package:http/http.dart' as http;
import '../env/environment.dart';
import 'auth_service.dart';

class CpfValidatorService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<bool> validarCpf(String cpf) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cpf/validar/$cpf'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == 'true';
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
