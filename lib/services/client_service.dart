import 'dart:convert';
import 'package:http/http.dart' as http;

import '../env/environment.dart';
import '../model/client.dart';
import 'auth_service.dart';

class ClientService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<List<Client>> searchClients(String search) async {
    final value = search.trim();

    if (value.length < 3) {
      return [];
    }

    final headers = await _getHeaders();

    final uri = Uri.parse(
      '$baseUrl/client/search',
    ).replace(queryParameters: {'search': value});

    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final data = jsonDecode(response.body) as List;

    return data.map((item) => Client.fromJson(item)).toList();
  }
}
