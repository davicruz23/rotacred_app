import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../env/environment.dart';

class ProductService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/product/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }
}
