import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import '../model/pre_sale.dart';
import '../model/dto/inspector_dto.dart';
import '../model/dto/inspector_history_pre_sale_dto.dart';
import 'auth_service.dart'; // certifique-se de importar seu AuthService

class InspectorService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService(); // para pegar o token

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<List<PreSale>> getPendingPreSales(int inspectorId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales/pending'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => PreSale.fromJson(json)).toList();
    } else {
      throw Exception(
        "Erro ao buscar pré-vendas pendentes (${response.statusCode})",
      );
    }
  }

  Future<void> approvePreSale({
    required int preSaleId,
    required int inspectorId,
    required String paymentMethod,
    required int installments,
    double? cashPaid,
    double? latitude,
    double? longitude,
  }) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/approve"),
      headers: headers,
      body: jsonEncode({
        "inspectorId": inspectorId,
        "paymentMethod": paymentMethod,
        "installments": installments,
        "cashPaid": cashPaid ?? 0,
        "latitude": latitude,
        "longitude": longitude,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao aprovar pré-venda (${response.statusCode})");
    }
  }

  Future<void> rejectPreSale(int preSaleId) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/reject"),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao recusar pré-venda (${response.statusCode})");
    }
  }

  Future<InspectorDTO> getInspectorByUserId(int userId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/inspector/by-user/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return InspectorDTO.fromJson(jsonData);
    } else {
      throw Exception(
        'Erro ao buscar Inspector pelo usuário (${response.statusCode})',
      );
    }
  }

  Future<List<InspectorHistoryPreSaleDto>> getHistoryByInspectorId(
    int inspectorId,
  ) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales-history');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList
          .map((e) => InspectorHistoryPreSaleDto.fromJson(e))
          .toList();
    } else {
      throw Exception("Erro ao carregar histórico (${response.statusCode})");
    }
  }
}
