import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rotacred_app/database/entities/client_local.dart';
import 'package:rotacred_app/database/entities/collector_local.dart';
import 'package:rotacred_app/database/entities/inspector_approve_local.dart';
import 'package:rotacred_app/database/entities/inspector_local.dart';
import 'package:rotacred_app/database/entities/inspector_pre_sale_local.dart';
import 'package:rotacred_app/database/entities/inspector_reject_local.dart';
import 'package:rotacred_app/database/entities/pre_sale_item_local.dart';
import 'package:rotacred_app/database/entities/pre_sale_local.dart';
import 'package:rotacred_app/database/entities/seller_local.dart';
import '../model/charging.dart';
import '../model/charging_item.dart';
import '../model/user.dart';

class DatabaseService {
  static late Isar isar;

  static Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      print("📂 DIR: ${dir.path}");

      isar = await Isar.open(
        [
          ChargingSchema,
          ChargingItemSchema,
          UserSchema,
          PreSaleLocalSchema,
          PreSaleItemLocalSchema,
          ClientLocalSchema,
          SellerLocalSchema,
          InspectorLocalSchema,
          InspectorPreSaleLocalSchema,
          InspectorApproveLocalSchema,
          InspectorRejectLocalSchema,
          CollectorLocalSchema,
        ],
        directory: dir.path,
        inspector: true,
      );

      print("✅ ISAR ABERTO COM SUCESSO");
    } catch (e, stack) {
      print("💣 ERRO AO ABRIR ISAR: $e");
      print(stack);
    }
  }
}
