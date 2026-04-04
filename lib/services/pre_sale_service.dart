import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import '../env/environment.dart';
import '../model/pre_sale.dart';
import '../model/pre_sale_item.dart';
import '../database/database_service.dart';
import '../database/entities/pre_sale_item_local.dart';
import '../database/entities/pre_sale_local.dart';
import '../database/entities/client_local.dart';
import '../database/entities/address_local.dart';
import '../model/client.dart';
import '../model/address.dart';
import '../model/dto/seller_dto.dart';
import 'charging_service.dart';

import 'auth_service.dart';

class PreSaleService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  final uuid = const Uuid();

  /// cria pré-venda
  Future<void> createPreSale(PreSale preSale) async {
    
    try {
      final headers = await _getHeaders();

      print(jsonEncode(preSale.toJson()));
      
      final response = await http.post(
        Uri.parse('$baseUrl/preSale'),
        headers: headers,
        body: jsonEncode(preSale.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.body);
      }

      await ChargingService().getChargings();
    } catch (e) {
      print("⚠️ API indisponível. Salvando pré-venda offline.");

      final isar = DatabaseService.isar;

      await isar.writeTxn(() async {
        /// 1️⃣ salva cliente local
        final clientLocal = ClientLocal()
          ..serverId = preSale.client.id
          ..name = preSale.client.name
          ..cpf = preSale.client.cpf
          ..phone = preSale.client.phone
          ..address = (AddressLocal()
            ..street = preSale.client.address.street
            ..number = preSale.client.address.number
            ..city = preSale.client.address.city
            ..state = preSale.client.address.state
            ..zipCode = preSale.client.address.zipCode
            ..complement = preSale.client.address.complement);

        final clientLocalId = await isar.clientLocals.put(clientLocal);

        /// 2️⃣ cria pré-venda local
        final preSaleLocal = PreSaleLocal()
          ..serverId = preSale.id
          ..preSaleDate = preSale.preSaleDate
          ..sellerId = preSale.seller.idSeller
          ..sellerName = preSale.seller.nomeSeller
          ..localUuid = preSale.uuidPreSale
          ..clientId = clientLocalId
          ..clientName = preSale.client.name
          ..clientCpf = preSale.client.cpf
          ..clientPhone = preSale.client.phone
          ..clientAddress = (AddressLocal()
            ..street = preSale.client.address.street
            ..number = preSale.client.address.number
            ..city = preSale.client.address.city
            ..state = preSale.client.address.state
            ..zipCode = preSale.client.address.zipCode
            ..complement = preSale.client.address.complement)
          ..inspector = preSale.inspector
          ..status = preSale.status
          ..chargingId = preSale.chargingId
          ..totalPreSale = preSale.totalPreSale;

        final preSaleLocalId = await isar.preSaleLocals.put(preSaleLocal);

        /// 3️⃣ salva itens
        for (final item in preSale.items) {
          final itemLocal = PreSaleItemLocal()
            ..preSaleLocalId = preSaleLocalId
            ..productId = item.productId
            ..productName = item.productName
            ..quantity = item.quantity
            ..unitPrice = item.unitPrice;

          await isar.preSaleItemLocals.put(itemLocal);
        }
      });
    }
  }

  /// busca pré-vendas
  Future<List<PreSale>> getPreSalesBySeller(int sellerId) async {
    try {
      final headers = await _getHeaders();

      final response = await http.get(
        Uri.parse('$baseUrl/pre-sale/seller/$sellerId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;

        final preSales = data.map((e) => PreSale.fromJson(e)).toList();

        /// salva local para cache offline
        final isar = DatabaseService.isar;

        await isar.writeTxn(() async {
          await isar.preSaleLocals.clear();
          await isar.preSaleItemLocals.clear();

          for (final p in preSales) {
            final local = PreSaleLocal()
              ..serverId = p.id
              ..preSaleDate = p.preSaleDate
              ..sellerId = p.seller.idSeller
              ..sellerName = p.seller.nomeSeller
              ..clientId = p.client.id!
              ..inspector = p.inspector
              ..status = p.status
              ..chargingId = p.chargingId
              ..totalPreSale = p.totalPreSale;

            final preSaleLocalId = await isar.preSaleLocals.put(local);

            for (final item in p.items) {
              final itemLocal = PreSaleItemLocal()
                ..preSaleLocalId = preSaleLocalId
                ..productId = item.productId
                ..productName = item.productName
                ..quantity = item.quantity
                ..unitPrice = item.unitPrice;

              await isar.preSaleItemLocals.put(itemLocal);
            }
          }
        });

        return preSales;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print("⚠️ API indisponível. Carregando pré-vendas do banco local.");

      final isar = DatabaseService.isar;

      final preSalesLocal = await isar.preSaleLocals.where().findAll();

      List<PreSale> result = [];

      for (final local in preSalesLocal) {
        /// busca cliente local
        final clientLocal = await isar.clientLocals.get(local.clientId);

        /// busca itens
        final itemsLocal = await isar.preSaleItemLocals
            .filter()
            .preSaleLocalIdEqualTo(local.id)
            .findAll();

        final items = itemsLocal.map((i) {
          return PreSaleItem(
            productId: i.productId,
            productName: i.productName,
            quantity: i.quantity,
            unitPrice: i.unitPrice,
          );
        }).toList();

        if (clientLocal == null) continue;

        result.add(
          PreSale(
            id: local.serverId,
            preSaleDate: local.preSaleDate,
            seller: SellerDTO(
              idSeller: local.sellerId,
              nomeSeller: local.sellerName,
            ),
            client: Client(
              id: clientLocal.serverId,
              name: clientLocal.name,
              cpf: clientLocal.cpf,
              phone: clientLocal.phone,
              address: Address(
                state: clientLocal.address?.state ?? '',
                street: clientLocal.address?.street ?? '',
                city: clientLocal.address?.city ?? '',
                number: clientLocal.address?.number ?? '',
                zipCode: clientLocal.address?.zipCode ?? '',
                complement: clientLocal.address?.complement ?? '',
              ),
            ),
            items: items,
            inspector: local.inspector,
            status: local.status,
            chargingId: local.chargingId,
            totalPreSale: local.totalPreSale,
            uuidPreSale: local.localUuid,
          ),
        );
      }

      return result;
    }
  }
}
