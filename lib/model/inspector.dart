import 'user.dart';
import 'pre_sale.dart';

class Inspector {
  final int? id;
  final User user;
  final List<PreSale> preSales;

  Inspector({
    this.id,
    required this.user,
    required this.preSales,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) {
    return Inspector(
      id: json['id'],
      user: User.fromJson(json['user']),
      preSales: json['preSales'] != null
          ? (json['preSales'] as List)
              .map((e) => PreSale.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user': user.toJson(),
      'preSales': preSales.map((e) => e.toJson()).toList(),
    };
  }
}
