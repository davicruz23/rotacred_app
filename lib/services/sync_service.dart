import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
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
    print("Sync iniciado");

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
}
