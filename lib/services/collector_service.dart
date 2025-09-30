import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotacred_app/env/environment.dart';
import 'package:rotacred_app/model/dto/collector_dto.dart';
import '../model/dto/sale_collector_dto.dart';

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
    print('id do pay ${installmentId}');
    final url = Uri.parse('$baseUrl/collector/$installmentId/pay');
    final response = await http.put(url);
    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao marcar pagamento da parcela ($installmentId): ${response.statusCode}',
      );
    }
  }
}
