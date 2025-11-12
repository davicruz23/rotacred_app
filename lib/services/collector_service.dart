import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import 'package:rotacred_app/model/dto/collector_dto.dart';
import '../model/dto/sale_collector_dto.dart';
import 'dart:typed_data';
import 'auth_service.dart'; // importa AuthService para pegar o token

class CollectorService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<Map<String, List<SaleCollectorDTO>>> getSalesForCollector(
    int collectorId,
  ) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$baseUrl/collector/$collectorId/sales');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return data.map((city, salesJson) {
        final salesList = (salesJson as List)
            .map((json) => SaleCollectorDTO.fromJson(json))
            .toList();
        return MapEntry(city, salesList);
      });
    } else {
      throw Exception(
        'Erro ao buscar vendas para cobrador ${response.statusCode}',
      );
    }
  }

  Future<CollectorDto> getCollectorByUserId(int userId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/collector/by-user/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return CollectorDto.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar Collector pelo usuário');
    }
  }

  Future<void> paySale(int installmentId) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$baseUrl/collector/$installmentId/pay');
    final response = await http.put(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao marcar pagamento da parcela ($installmentId): ${response.statusCode}',
      );
    }
  }

  Future<void> collectInstallment({
    required int collectorId,
    required int installmentId,
    double? amount,
    String? paymentMethod,
    double? latitude,
    double? longitude,
    String? note,
    DateTime? newDueDate,
  }) async {
    final headers = await _getHeaders();
    final url = Uri.parse(
      '$baseUrl/collector/$collectorId/installment/$installmentId/collect',
    );

    final payload = {
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (note != null) 'note': note,
      if (newDueDate != null) 'newDueDate': newDueDate.toIso8601String(),
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao registrar tentativa de cobrança: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<Uint8List> getPixQrCode(int installmentId) async {
    final headers = await _getHeaders();
    final url = Uri.parse('$baseUrl/collector/installment/$installmentId/pix');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.bodyBytes; // retorna a imagem PNG
    } else {
      throw Exception(
        'Erro ao buscar QR Code PIX: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
