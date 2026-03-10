import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';

import '../env/environment.dart';
import '../database/database_service.dart';
import '../database/entities/seller_local.dart';
import '../model/dto/seller_dto.dart';
import 'auth_service.dart';

class SellerService {
  final String baseUrl = Environment.apiBaseUrl;
  final AuthService _authService = AuthService();

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

  Future<SellerDTO> getSellerByUserId(int userId) async {
    final isar = DatabaseService.isar;
    final online = await _isOnline();

    /// ===== ONLINE =====
    if (online) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/seller/by-user/$userId'),
          headers: await _getHeaders(),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          final seller = SellerDTO.fromJson(jsonData);

          /// salva no banco local
          final sellerLocal = SellerLocal()
            ..serverId = seller.idSeller
            ..userId = userId
            ..userName = seller.nomeSeller;

          await isar.writeTxn(() async {
            final existingSeller = await isar.sellerLocals
                .filter()
                .userIdEqualTo(userId)
                .findFirst();

            if (existingSeller != null) {
              sellerLocal.id = existingSeller.id; // força update
            }

            await isar.sellerLocals.put(sellerLocal);
          });

          return seller;
        }
      } catch (e) {
        print("Erro ao buscar seller online: $e");
      }
    }

    /// ===== FALLBACK OFFLINE =====
    final sellerLocal = await isar.sellerLocals
        .filter()
        .userIdEqualTo(userId)
        .findFirst();

    if (sellerLocal == null) {
      throw Exception("Seller não encontrado no banco local");
    }

    return SellerDTO(
      idSeller: sellerLocal.serverId ?? 0,
      nomeSeller: sellerLocal.userName,
    );
  }
}
