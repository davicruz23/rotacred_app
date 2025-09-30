import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/model/dto/seller_dto.dart';
import '../env/environment.dart';

class SellerService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<SellerDTO> getSellerByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/seller/by-user/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return SellerDTO.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar Seller pelo usuário');
    }
  }
}
