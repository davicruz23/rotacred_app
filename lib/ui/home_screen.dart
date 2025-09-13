import 'package:flutter/material.dart';
import 'package:rotacred_app/ui/seller/seller_screen.dart';
import '../model/user.dart';
import 'funcionario/funcionario_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    switch (user.position) {
      case 'FUNCIONARIO':
        return FuncionarioScreen(user: user);
       case 'VENDEDOR':
         return SellerScreen(user: user);
      default:
        return Scaffold(
          body: Center(
            child: Text('Tela não implementada para ${user.position}'),
          ),
        );
    }
  }
}
