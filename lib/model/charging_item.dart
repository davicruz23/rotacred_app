import 'charging.dart';
import 'product.dart';
import 'pre_sale.dart';

class ChargingItem {
  final int? id;
  final Charging? charging;
  final Product product;
  final int quantity;
  final PreSale? preSale;

  ChargingItem({
    this.id,
    this.charging,
    required this.product,
    required this.quantity,
    this.preSale,
  });

  factory ChargingItem.fromJson(Map<String, dynamic> json) {
    return ChargingItem(
      id: json['id'],
      charging: json['charging'] != null ? Charging.fromJson(json['charging']) : null,
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      preSale: json['preSale'] != null ? PreSale.fromJson(json['preSale']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (charging != null) 'charging': charging!.toJson(),
      'product': product.toJson(),
      'quantity': quantity,
      if (preSale != null) 'preSale': preSale!.toJson(),
    };
  }
}
