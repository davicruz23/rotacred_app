import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

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

  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }

  Future<bool?> validarCpf(String cpf) async {
    final online = await isOnline();

    if (!online) {
      print("📴 Offline - pulando validação de CPF");
      return null; // 🔥 mudou aqui
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cpf/validar/$cpf'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == 'true';
      }

      return null; // 🔥 não assume erro
    } catch (e) {
      print("Erro ao validar CPF: $e");
      return null; // 🔥 não assume erro
    }
  }
}
