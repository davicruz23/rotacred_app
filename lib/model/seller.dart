import 'user.dart';

class Seller {
  final int id;
  final User user;
  final double totalCommission;

  Seller({
    required this.id,
    required this.user,
    required this.totalCommission,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json['id'],
        user: User.fromJson(json['user']),
        totalCommission: (json['totalCommission'] ?? 0.0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'totalCommission': totalCommission,
      };
}
