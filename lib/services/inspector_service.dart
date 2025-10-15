import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import '../model/pre_sale.dart';
import '../model/dto/inspector_dto.dart';
import '../model/dto/inspector_history_pre_sale_dto.dart';

class InspectorService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<List<PreSale>> getPendingPreSales(int inspectorId) async {
    //print('id do fiscal $inspectorId');
    final response = await http.get(
      Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales/pending'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      //print('Retorno da API: ${response.body}');
      return body.map((json) => PreSale.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao buscar pré-vendas pendentes");
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
    final response = await http.post(
      Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/approve"),
      headers: {"Content-Type": "application/json"},
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
      throw Exception("Erro ao aprovar pré-venda");
    }
  }

  Future<void> rejectPreSale(int preSaleId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/reject"),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao recusar pré-venda");
    }
  }

  Future<InspectorDTO> getInspectorByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/inspector/by-user/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return InspectorDTO.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar Inspector pelo usuário');
    }
  }

  Future<List<InspectorHistoryPreSaleDto>> getHistoryByInspectorId(
    int inspectorId,
  ) async {
    final url = Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales-history');
    final response = await http.get(url);
    //print('📦 Retorno da API: ${response.body}');
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
