import 'user.dart';
import 'sale.dart';

class Collector {
  final int? id;
  final User user;
  final List<Sale> sales;

  Collector({
    this.id,
    required this.user,
    required this.sales,
  });

  factory Collector.fromJson(Map<String, dynamic> json) {
    return Collector(
      id: json['id'],
      user: User.fromJson(json['user']),
      sales: json['sales'] != null
          ? (json['sales'] as List).map((e) => Sale.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user': user.toJson(),
      'sales': sales.map((e) => e.toJson()).toList(),
    };
  }
}
