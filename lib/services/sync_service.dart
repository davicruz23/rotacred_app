import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:rotacred_app/database/entities/inspector_approve_local.dart';
import 'package:rotacred_app/database/entities/inspector_pre_sale_local.dart';
import 'package:rotacred_app/database/entities/inspector_reject_local.dart';
import 'package:rotacred_app/model/address.dart';
import 'package:rotacred_app/model/charging.dart';
import 'package:rotacred_app/model/client.dart';
import 'package:rotacred_app/model/dto/seller_dto.dart';
import 'package:rotacred_app/model/pre_sale.dart';
import 'package:rotacred_app/model/pre_sale_item.dart';

import '../database/database_service.dart';
import '../database/entities/pre_sale_local.dart';
import '../database/entities/pre_sale_item_local.dart';
import '../env/environment.dart';
import 'auth_service.dart';

class SyncService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  bool _isSyncing = false;
  bool _isSyncingApprovals = false;
  bool _isSyncingRejects = false;

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<bool> _isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// sincroniza todas as pré-vendas offline
  Future<void> syncPreSales() async {
    print("Sync iniciado de Pré-Vendas");

    if (_isSyncing) return;

    final online = await _isOnline();
    if (!online) return;

    _isSyncing = true;

    final isar = DatabaseService.isar;

    try {
      final pending = await isar.preSaleLocals
          .filter()
          .syncedEqualTo(false)
          .sortByPreSaleDate()
          .findAll();

      for (final preSaleLocal in pending) {
        try {
          final itemsLocal = await isar.preSaleItemLocals
              .filter()
              .preSaleLocalIdEqualTo(preSaleLocal.id)
              .findAll();

          /// reconstrói lista de itens
          final items = itemsLocal
              .map(
                (i) => PreSaleItem(
                  productId: i.productId,
                  productName: i.productName,
                  quantity: i.quantity,
                  unitPrice: i.unitPrice,
                ),
              )
              .toList();

          /// reconstrói client
          final client = Client(
            id: 0,
            name: preSaleLocal.clientName,
            cpf: preSaleLocal.clientCpf,
            phone: preSaleLocal.clientPhone,
            address: Address(
              id: 0,
              street: preSaleLocal.clientAddress?.street ?? "",
              number: preSaleLocal.clientAddress?.number ?? "",
              city: preSaleLocal.clientAddress?.city ?? "",
              state: preSaleLocal.clientAddress?.state ?? "",
              zipCode: preSaleLocal.clientAddress?.zipCode ?? "",
              complement: preSaleLocal.clientAddress?.complement ?? "",
            ),
          );

          /// reconstrói seller mínimo
          final seller = SellerDTO(
            idSeller: preSaleLocal.sellerId,
            nomeSeller: preSaleLocal.sellerName,
          );

          Charging? charging;

          if (preSaleLocal.chargingId != null) {
            charging = await isar.chargings.get(preSaleLocal.chargingId!);
          }

          /// reconstrói PreSale usando o mesmo model
          final preSale = PreSale(
            id: null,
            uuidPreSale: preSaleLocal.localUuid,
            preSaleDate: preSaleLocal.preSaleDate,
            seller: seller,
            client: client,
            items: items,
            chargingId: charging?.serverId,
          );

          /// usa o mesmo serializer
          final body = preSale.toJson();

          print("SYNC JSON: ${jsonEncode(body)}");

          final response = await http.post(
            Uri.parse('$baseUrl/preSale'),
            headers: await _getHeaders(),
            body: jsonEncode(body),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            await isar.writeTxn(() async {
              preSaleLocal.synced = true;
              await isar.preSaleLocals.put(preSaleLocal);
            });

            print("✅ Venda ${preSaleLocal.id} sincronizada");
          } else {
            print("⚠ erro ao enviar venda ${preSaleLocal.id}");
            print("Status: ${response.statusCode}");
            print("Body: ${response.body}");
          }
        } catch (e) {
          print("Erro ao sincronizar venda ${preSaleLocal.id}: $e");
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> syncInspectorApprovals() async {
    if (_isSyncingApprovals) return;

    final online = await _isOnline();
    if (!online) return;

    _isSyncingApprovals = true;

    final isar = DatabaseService.isar;

    try {
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

              await isar.preSaleLocals.delete(item.preSaleId);

              final items = await isar.preSaleItemLocals
                  .filter()
                  .preSaleLocalIdEqualTo(item.preSaleId)
                  .findAll();

              for (final i in items) {
                await isar.preSaleItemLocals.delete(i.id);
              }
            });

            print("✅ Approve ${item.id} sincronizado e removido");
          }
        } catch (e) {
          print("Erro approve ${item.id}: $e");
        }
      }
    } finally {
      _isSyncingApprovals = false;
    }
  }

  Future<void> syncInspectorRejects() async {
    if (_isSyncingRejects) return;

    final online = await _isOnline();
    if (!online) return;

    _isSyncingRejects = true;

    final isar = DatabaseService.isar;

    try {
      final pending = await isar.inspectorRejectLocals.where().findAll();

      for (final item in pending) {
        try {
          final headers = await _getHeaders();

          final response = await http.post(
            Uri.parse("$baseUrl/inspector/pre-sales/${item.preSaleId}/reject"),
            headers: headers,
          );

          if (response.statusCode == 200) {
            await isar.writeTxn(() async {
              // 🔥 remove da fila de sync
              await isar.inspectorRejectLocals.delete(item.id);

              // 🔥 remove a pre-sale local
              final local = await isar.inspectorPreSaleLocals
                  .filter()
                  .serverIdEqualTo(item.preSaleId)
                  .findFirst();

              if (local != null) {
                await isar.inspectorPreSaleLocals.delete(local.id);
              }
            });

            print("❌ Reject ${item.id} sincronizado e removido");
          }
        } catch (e) {
          print("Erro reject ${item.id}: $e");
        }
      }
    } finally {
      _isSyncingRejects = false;
    }
  }

  Future<void> syncAll() async {
    await syncPreSales();
    await syncInspectorApprovals();
    await syncInspectorRejects();
  }
}
