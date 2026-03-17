import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:rotacred_app/database/database_service.dart';
import 'package:rotacred_app/database/entities/inspector_approve_local.dart';
import 'package:rotacred_app/database/entities/inspector_local.dart';
import 'package:rotacred_app/database/entities/inspector_pre_sale_local.dart';
import 'package:rotacred_app/env/environment.dart';
import 'package:rotacred_app/model/address.dart';
import 'package:rotacred_app/model/client.dart';
import 'package:rotacred_app/model/dto/seller_dto.dart';
import 'package:rotacred_app/model/pre_sale_item.dart';
import '../model/pre_sale.dart';
import '../model/dto/inspector_dto.dart';
import '../model/dto/inspector_history_pre_sale_dto.dart';
import 'auth_service.dart'; // certifique-se de importar seu AuthService

class InspectorService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService(); // para pegar o token

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

  Future<InspectorDTO> getInspectorByUserId(int userId) async {
    final isar = DatabaseService.isar;
    final online = await isOnline();

    if (online) {
      try {
        final headers = await _getHeaders();
        final response = await http.get(
          Uri.parse('$baseUrl/inspector/by-user/$userId'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          final inspector = InspectorDTO.fromJson(jsonData);

          final inspectorLocal = InspectorLocal()
            ..serverId = inspector.idInspector
            ..userId = userId;

          await isar.writeTxn(() async {
            final existingInspector = await isar.inspectorLocals
                .filter()
                .userIdEqualTo(userId)
                .findFirst();

            if (existingInspector != null) {
              inspectorLocal.id = existingInspector.id;
            }

            await isar.inspectorLocals.put(inspectorLocal);
          });
          return inspector;
        }
      } catch (e) {
        print("Erro ao buscar Fiscal online: $e");
      }
    }

    final inspectorLocal = await isar.inspectorLocals
        .filter()
        .userIdEqualTo(userId)
        .findFirst();

    if (inspectorLocal == null) {
      throw Exception("Fiscal não encontrado no banco local");
    }

    return InspectorDTO(idInspector: inspectorLocal.serverId ?? 0);
  }

  Future<List<PreSale>> getPendingPreSales(int inspectorId) async {
    final isar = DatabaseService.isar;

    // 🔥 SINCRONIZA E REMOVE LOCAL IMEDIATAMENTE
    final pendingApprovals = await isar.inspectorApproveLocals
        .where()
        .findAll();

    for (final item in pendingApprovals) {
      try {
        final headers = await _getHeaders();

        final response = await http.post(
          Uri.parse("$baseUrl/inspector/pre-sales/${item.preSaleId}/approve"),
          headers: headers,
          body: jsonEncode({
            "inspectorId": item.inspectorId,
            "paymentMethod": item.paymentMethod,
            "installments": item.installments,
            "cashPaid": item.cashPaid ?? 0,
            "latitude": item.latitude,
            "longitude": item.longitude,
          }),
        );

        if (response.statusCode == 200) {
          await isar.writeTxn(() async {
            // remove approve
            await isar.inspectorApproveLocals.delete(item.id);

            // 🔥 remove da lista do inspector (RESOLVE TEU PROBLEMA)
            final local = await isar.inspectorPreSaleLocals
                .filter()
                .serverIdEqualTo(item.preSaleId)
                .and()
                .inspectorIdEqualTo(inspectorId)
                .findFirst();

            if (local != null) {
              await isar.inspectorPreSaleLocals.delete(local.id);
            }
          });
        }
      } catch (_) {}
    }

    final online = await isOnline();

    if (online) {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales/pending'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        final preSales = body.map((json) => PreSale.fromJson(json)).toList();

        await isar.writeTxn(() async {
          final localList = await isar.inspectorPreSaleLocals
              .filter()
              .inspectorIdEqualTo(inspectorId)
              .findAll();

          final serverIds = preSales.map((e) => e.id).toSet();

          for (final local in localList) {
            if (!serverIds.contains(local.serverId)) {
              await isar.inspectorPreSaleLocals.delete(local.id);
            }
          }

          for (final preSale in preSales) {
            final existing = await isar.inspectorPreSaleLocals
                .filter()
                .serverIdEqualTo(preSale.id!)
                .and()
                .inspectorIdEqualTo(inspectorId)
                .findFirst();

            final local = InspectorPreSaleLocal.fromPreSale(
              preSale,
              inspectorId,
            );

            if (existing != null) {
              local.id = existing.id;
            }

            await isar.inspectorPreSaleLocals.put(local);
          }
        });

        return preSales;
      }
    }

    // OFFLINE
    final localList = await isar.inspectorPreSaleLocals
        .filter()
        .inspectorIdEqualTo(inspectorId)
        .findAll();

    return localList.map((local) {
      final items = (jsonDecode(local.itemsJson) as List)
          .map((e) => PreSaleItem.fromJson(e))
          .toList();

      return PreSale(
        id: local.serverId,
        preSaleDate: local.preSaleDate,
        seller: SellerDTO(
          idSeller: local.sellerId,
          nomeSeller: local.sellerName,
        ),
        client: Client(
          id: local.clientId,
          name: local.clientName,
          cpf: local.clientCpf,
          phone: local.clientPhone,
          address: Address(
            id: 0,
            state: local.clientState,
            city: local.clientCity,
            street: local.clientStreet,
            number: local.clientNumber,
            zipCode: local.clientZipCode,
            complement: local.clientComplement,
          ),
        ),
        items: items,
        inspector: null,
        status: local.status,
        chargingId: null,
        totalPreSale: local.totalPreSale,
        uuidPreSale: '',
      );
    }).toList();
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
    final isar = DatabaseService.isar;
    final online = await isOnline();

    if (online) {
      try {
        final headers = await _getHeaders();

        final response = await http.post(
          Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/approve"),
          headers: headers,
          body: jsonEncode({
            "inspectorId": inspectorId,
            "paymentMethod": paymentMethod,
            "installments": installments,
            "cashPaid": cashPaid ?? 0,
            "latitude": latitude,
            "longitude": longitude,
          }),
        );

        if (response.statusCode == 200) {
          return;
        }
      } catch (e) {
        print("Erro online approve: $e");
      }
    }

    // OFFLINE → salvar no Isar
    final local = InspectorApproveLocal()
      ..preSaleId = preSaleId
      ..inspectorId = inspectorId
      ..paymentMethod = paymentMethod
      ..installments = installments
      ..cashPaid = cashPaid
      ..latitude = latitude
      ..longitude = longitude
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.inspectorApproveLocals.put(local);
    });
  }

  Future<void> rejectPreSale(int preSaleId) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse("$baseUrl/inspector/pre-sales/$preSaleId/reject"),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao recusar pré-venda (${response.statusCode})");
    }
  }

  Future<List<InspectorHistoryPreSaleDto>> getHistoryByInspectorId(
    int inspectorId,
  ) async {
    final online = await isOnline();

    if (!online) {
      return [];
    }

    final headers = await _getHeaders();
    final url = Uri.parse('$baseUrl/inspector/$inspectorId/pre-sales-history');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList
          .map((e) => InspectorHistoryPreSaleDto.fromJson(e))
          .toList();
    } else {
      throw Exception("Erro ao carregar histórico (${response.statusCode})");
    }
  }

  Future<void> syncOfflineApprovals() async {
    final isar = DatabaseService.isar;
    final online = await isOnline();

    if (!online) return;

    final pending = await isar.inspectorApproveLocals.where().findAll();

    for (final item in pending) {
      try {
        final headers = await _getHeaders();

        final response = await http.post(
          Uri.parse("$baseUrl/inspector/pre-sales/${item.preSaleId}/approve"),
          headers: headers,
          body: jsonEncode({
            "inspectorId": item.inspectorId,
            "paymentMethod": item.paymentMethod,
            "installments": item.installments,
            "cashPaid": item.cashPaid ?? 0,
            "latitude": item.latitude,
            "longitude": item.longitude,
          }),
        );

        if (response.statusCode == 200) {
          await isar.writeTxn(() async {
            await isar.inspectorApproveLocals.delete(item.id);
          });
        }
      } catch (e) {
        print("Erro sincronizando approve: $e");
      }
    }
  }

  Future<void> syncPendingPreSales(int inspectorId) async {
    final isar = DatabaseService.isar;

    final pendingApprovals = await isar.inspectorApproveLocals
        .where()
        .findAll();

    for (final item in pendingApprovals) {
      try {
        final headers = await _getHeaders();

        final response = await http.post(
          Uri.parse("$baseUrl/inspector/pre-sales/${item.preSaleId}/approve"),
          headers: headers,
          body: jsonEncode({
            "inspectorId": item.inspectorId,
            "paymentMethod": item.paymentMethod,
            "installments": item.installments,
            "cashPaid": item.cashPaid ?? 0,
            "latitude": item.latitude,
            "longitude": item.longitude,
          }),
        );

        if (response.statusCode == 200) {
          await isar.writeTxn(() async {
            await isar.inspectorApproveLocals.delete(item.id);

            final local = await isar.inspectorPreSaleLocals
                .filter()
                .serverIdEqualTo(item.preSaleId)
                .and()
                .inspectorIdEqualTo(inspectorId)
                .findFirst();

            if (local != null) {
              await isar.inspectorPreSaleLocals.delete(local.id);
            }
          });
        }
      } catch (_) {}
    }
  }

  Future<List<PreSale>> getLocalPreSales(int inspectorId) async {
    final isar = DatabaseService.isar;

    final localList = await isar.inspectorPreSaleLocals
        .filter()
        .inspectorIdEqualTo(inspectorId)
        .findAll();

    return localList.map((local) {
      final items = (jsonDecode(local.itemsJson) as List)
          .map((e) => PreSaleItem.fromJson(e))
          .toList();

      return PreSale(
        id: local.serverId,
        preSaleDate: local.preSaleDate,
        seller: SellerDTO(
          idSeller: local.sellerId,
          nomeSeller: local.sellerName,
        ),
        client: Client(
          id: local.clientId,
          name: local.clientName,
          cpf: local.clientCpf,
          phone: local.clientPhone,
          address: Address(
            id: 0,
            state: local.clientState,
            city: local.clientCity,
            street: local.clientStreet,
            number: local.clientNumber,
            zipCode: local.clientZipCode,
            complement: local.clientComplement,
          ),
        ),
        items: items,
        inspector: null,
        status: local.status,
        chargingId: null,
        totalPreSale: local.totalPreSale,
        uuidPreSale: '',
      );
    }).toList();
  }
}
