import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import '../model/pre_sale.dart';

class InspectorService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<List<PreSale>> getPendingPreSales(int inspectorId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales/pending'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => PreSale.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao buscar pré-vendas pendentes");
    }
  }
}
