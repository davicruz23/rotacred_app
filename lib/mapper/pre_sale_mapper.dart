import '../model/pre_sale.dart';
import '../database/entities/pre_sale_local.dart';

class PreSaleMapper {

  static PreSaleLocal toLocal(PreSale preSale) {

    final local = PreSaleLocal();

    local.serverId = preSale.id;
    local.preSaleDate = preSale.preSaleDate;

    local.sellerId = preSale.seller.idSeller;
    local.sellerName = preSale.seller.nomeSeller;

    local.clientId = preSale.client.id!;
    local.clientName = preSale.client.name;

    local.inspector = preSale.inspector;
    local.status = preSale.status;
    local.chargingId = preSale.chargingId;
    local.totalPreSale = preSale.totalPreSale;

    return local;
  }

}