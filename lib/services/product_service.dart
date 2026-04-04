import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../env/environment.dart';
import 'auth_service.dart'; // importa AuthService para pegar o token

class ProductService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<List<Product>> getProducts() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/product/all'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }

  Future<Map<String, dynamic>> getProductsPaged({
    int page = 0,
    int size = 10,
  }) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/product/index?page=$page&size=$size'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<Product> products = (data['content'] as List)
          .map((e) => Product.fromJson(e))
          .toList();

      return {
        'content': products,
        'totalElements': data['totalElements'],
        'totalPages': data['totalPages'],
        'pageNumber': data['number'],
      };
    } else {
      throw Exception('Erro ao buscar produtos paginados');
    }
  }
}
