import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/model/dto/seller_dto.dart';
import '../env/environment.dart';
import 'auth_service.dart'; // importa AuthService para pegar o token

class SellerService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<SellerDTO> getSellerByUserId(int userId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/seller/by-user/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return SellerDTO.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar Seller pelo usuário');
    }
  }
}
