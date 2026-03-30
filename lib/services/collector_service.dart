import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:rotacred_app/database/database_service.dart';
import 'package:rotacred_app/database/entities/collector_local.dart';
import 'package:rotacred_app/database/entities/pending_payment_local.dart';
import 'package:rotacred_app/database/entities/sale_return_local.dart';
import 'package:rotacred_app/env/environment.dart';
import 'package:rotacred_app/model/dto/collector_dto.dart';
import '../model/dto/sale_collector_dto.dart';
import '../database/entities/sales_collector_local.dart';
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

  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  Future<Map<String, List<SaleCollectorDTO>>> getSalesForCollector(
    int collectorId,
  ) async {
    final isar = DatabaseService.isar;

    final online = await isOnline();

    if (online) {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/collector/$collectorId/sales');
      final response = await http.get(url, headers: headers);

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print('JSON DECODED: $data');

        final result = data.map((city, salesJson) {
          final salesList = (salesJson as List)
              .map((json) => SaleCollectorDTO.fromJson(json))
              .toList();
          return MapEntry(city, salesList);
        });

        final localList = data.entries.expand((entry) {
          final city = entry.key;
          final list = entry.value as List;

          return list.map((json) => SaleCollectorLocal.fromJson(city, json));
        }).toList();

        await isar.writeTxn(() async {
          final existing = await isar.saleCollectorLocals.where().findAll();

          final serverIds = localList.map((e) => e.saleId).toSet();

          for (final item in existing) {
            if (!serverIds.contains(item.saleId)) {
              await isar.saleCollectorLocals.delete(item.id);
            }
          }

          for (final sale in localList) {
            final existingItem = await isar.saleCollectorLocals
                .filter()
                .saleIdEqualTo(sale.saleId)
                .findFirst();

            if (existingItem != null) {
              sale.id = existingItem.id;
            }

            await isar.saleCollectorLocals.put(sale);
          }
        });

        return result;
      }
    }

    final localList = await isar.saleCollectorLocals.where().findAll();

    final Map<String, List<SaleCollectorDTO>> result = {};

    for (final sale in localList) {
      final dto = SaleCollectorDTO.fromLocal(sale);

      if (!result.containsKey(sale.city)) {
        result[sale.city] = [];
      }

      result[sale.city]!.add(dto);
    }

    return result;
  }

  Future<CollectorDto> getCollectorByUserId(int userId) async {
    final isar = DatabaseService.isar;
    final online = await isOnline();

    if (online) {
      try {
        final headers = await _getHeaders();
        final response = await http.get(
          Uri.parse('$baseUrl/collector/by-user/$userId'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          final collector = CollectorDto.fromJson(jsonData);

          final collectorLocal = CollectorLocal()
            ..serverId = collector.idCollector
            ..userId = userId;

          await isar.writeTxn(() async {
            final existingCollector = await isar.collectorLocals
                .filter()
                .userIdEqualTo(userId)
                .findFirst();

            if (existingCollector != null) {
              collectorLocal.id = existingCollector.id;
            }

            await isar.collectorLocals.put(collectorLocal);
          });

          return collector;
        }
      } catch (e) {
        print("Erro ao buscar Cobrador online: $e");
      }
    }

    final collectorLocal = await isar.collectorLocals
        .filter()
        .userIdEqualTo(userId)
        .findFirst();

    if (collectorLocal == null) {
      throw Exception("Cobrador não encontrado no banco locaal");
    }

    return CollectorDto(idCollector: collectorLocal.serverId ?? 0);
  }

  Future<void> paySale({
    required int installmentId,
    required double amount,
  }) async {
    final online = await isOnline();

    print("🟡 [paySale] INICIO");
    print("➡ installmentId: $installmentId");
    print("➡ amount: $amount");

    if (online) {
      try {
        final headers = await _getHeaders();

        final url = Uri.parse(
          '$baseUrl/collector/$installmentId/pay?amount=${amount.toStringAsFixed(2)}',
        );

        print("🌐 ONLINE");
        print("➡ URL: $url");

        final response = await http.put(url, headers: headers);

        print("⬅ STATUS: ${response.statusCode}");
        print("⬅ BODY: ${response.body}");

        if (response.statusCode == 200) {
          print("✅ SUCESSO ONLINE (paySale)");
          return;
        }
      } catch (e) {
        print("❌ Erro no paySale online: $e");
      }
    }

    // 🔴 OFFLINE → NÃO salva isolado mais
    print("⚠️ paySale offline será tratado junto com collectInstallment");
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
    bool requiresPaySale = false,
  }) async {
    final isar = DatabaseService.isar;
    final online = await isOnline();

    print("🟡 [collectInstallment] INICIO");
    print("➡ collectorId: $collectorId");
    print("➡ installmentId: $installmentId");
    print("➡ amount: $amount");

    if (online) {
      try {
        final headers = await _getHeaders();

        // 🔥 PAY PRIMEIRO
        if (requiresPaySale && amount != null) {
          final payUrl = Uri.parse(
            '$baseUrl/collector/$installmentId/pay?amount=${amount.toStringAsFixed(2)}',
          );

          final payResponse = await http.put(payUrl, headers: headers);

          if (payResponse.statusCode != 200) {
            throw Exception("Erro no paySale online");
          }
        }

        // 🔥 DEPOIS COLLECT
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
          headers: {...headers, "Content-Type": "application/json"},
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          print("✅ SUCESSO ONLINE");
          return;
        }
      } catch (e) {
        print("❌ Erro online: $e");
      }
    }

    // 🔴 OFFLINE → SALVA COMPLETO
    print("🔴 SALVANDO NO ISAR");

    await isar.writeTxn(() async {
      final entity = PendingPayment()
        ..collectorId = collectorId
        ..installmentId = installmentId
        ..amount = amount
        ..paymentMethod = paymentMethod
        ..latitude = latitude
        ..longitude = longitude
        ..note = note
        ..newDueDate = newDueDate
        ..requiresPaySale = requiresPaySale
        ..paySent =
            false // 🔥 AQUI É O CERTO
        ..createdAt = DateTime.now();

      await isar.pendingPayments.put(entity);
    });
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

  Future<void> reportProblem({
    required int saleId,
    required List<Map<String, dynamic>> items,
    required int status,
    String? description,
  }) async {
    final isar = DatabaseService.isar;
    final online = await isOnline();

    final headers = await _getHeaders();

    final formattedItems = items.map((item) {
      return {
        "productId": item["productId"],
        "quantityReturned": item["quantityReturned"],
      };
    }).toList();

    final body = {
      "items": formattedItems,
      "status": status,
      "description": description ?? "",
    };

    final url = '$baseUrl/sale-return/sales/$saleId/returns';

    print("========== JSON FINAL ==========");
    print(JsonEncoder.withIndent('  ').convert(body));

    if (online) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {...headers, "Content-Type": "application/json"},
          body: jsonEncode(body),
        );

        print("STATUS: ${response.statusCode}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("✅ SUCESSO ONLINE");
          return;
        }
      } catch (e) {
        print("❌ erro online: $e");
      }
    }

    // 🔴 OFFLINE
    print("🔴 SALVANDO RETORNO NO ISAR");

    await isar.writeTxn(() async {
      final entity = SaleReturnLocal()
        ..saleId = saleId
        ..itemsJson = formattedItems.map((e) => jsonEncode(e)).toList()
        ..status = status
        ..description = description
        ..createdAt = DateTime.now();

      await isar.saleReturnLocals.put(entity);
    });
  }
}
