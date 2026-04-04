import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env/environment.dart';
import 'auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CepService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<Map<String, dynamic>?> buscarPorCep(String cep) async {
    final online = await isOnline(); // 🔥 mesma lógica do CPF

    if (!online) {
      print("📴 Offline - não vai buscar CEP");
      return null;
    }

    try {
      final headers = await _getHeaders();

      final response = await http.get(
        Uri.parse('$baseUrl/cep/$cep'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }

      return null; // 🔥 não estoura erro
    } catch (e) {
      print("⚠️ Erro ao buscar CEP: $e");
      return null;
    }
  }
}
