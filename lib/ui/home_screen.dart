import 'package:flutter/material.dart';
import '../model/user.dart';
import 'funcionario_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    switch (user.position) {
      case 'FUNCIONARIO':
        return FuncionarioScreen(user: user);
      // case 'VENDEDOR':
      //   return VendedorScreen(user: user);
      default:
        return Scaffold(
          body: Center(
            child: Text('Tela não implementada para ${user.position}'),
          ),
        );
    }
  }
}
