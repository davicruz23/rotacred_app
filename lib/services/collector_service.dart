import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import 'package:rotacred_app/model/dto/collector_dto.dart';
import '../model/dto/sale_collector_dto.dart';
import '../model//dto/collection_attempt_dto.dart';
import 'dart:typed_data';

class CollectorService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<List<SaleCollectorDTO>> getSalesForCollector(int collectorId) async {
    final url = Uri.parse('$baseUrl/collector/$collectorId/sales');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => SaleCollectorDTO.fromJson(json)).toList();
    } else {
      throw Exception(
        'Erro ao buscar vendas para cobrador ${response.statusCode}',
      );
    }
  }

  Future<CollectorDto> getCollectorByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/collector/by-user/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return CollectorDto.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar Inspector pelo usuário');
    }
  }

  Future<void> paySale(int installmentId) async {
    final url = Uri.parse('$baseUrl/collector/$installmentId/pay');
    final response = await http.put(url);
    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao marcar pagamento da parcela ($installmentId): ${response.statusCode}',
      );
    }
  }

  /*Future<void> payInstallment(CollectionAttemptDTO attempt) async {
    final url = Uri.parse('$baseUrl/collector/attempt');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(attempt.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Erro ao registrar pagamento: ${response.statusCode} - ${response.body}');
    }
  }*/

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
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao registrar tentativa de cobrança: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<Uint8List> getPixQrCode(int installmentId) async {
    final url = Uri.parse('$baseUrl/collector/installment/$installmentId/pix');
    final response = await http.get(url);

    print('retorno do QR: ${response}:::::::: ${installmentId}');
    if (response.statusCode == 200) {
      print('status: ${response.statusCode}');
      print('tamanho do body: ${response.bodyBytes.length}');
      return response.bodyBytes; // retorna a imagem PNG
    } else {
      throw Exception(
        'Erro ao buscar QR Code PIX: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
