import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env/environment.dart';
import '../model/pre_sale.dart';

class PreSaleService {
  final String baseUrl = Environment.apiBaseUrl;

  /// Cria uma nova pré-venda
  Future<void> createPreSale(PreSale preSale) async {
    final response = await http.post(
      Uri.parse('$baseUrl/preSale'), // endpoint de criação da pré-venda
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(preSale.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao criar pré-venda: ${response.body}');
    }
  }

  Future<List<PreSale>> getPreSalesBySeller(int sellerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pre-sale/seller/$sellerId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => PreSale.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar pré-vendas: ${response.body}');
    }
  }
}
