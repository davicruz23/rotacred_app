import 'package:flutter/material.dart';
import 'package:rotacred_app/ui/collector/collector_screen.dart';
import 'package:rotacred_app/ui/fiscal/inspector_screen.dart';
import 'package:rotacred_app/ui/seller/seller_screen.dart';
import '../model/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    switch (user.position) {
      case 'ROLE_VENDEDOR':
        return SellerScreen(user: user);
      case 'ROLE_FISCAL':
        return InspectorScreen(user: user);
      case 'ROLE_COBRADOR':
        return CollectorScreen(user: user);
      default:
        return Scaffold(
          body: Center(
            child: Text('Tela não implementada para ${user.position}'),
          ),
        );
    }
  }
}