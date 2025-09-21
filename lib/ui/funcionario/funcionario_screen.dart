import 'package:flutter/material.dart';
import 'package:rotacred_app/model/user.dart';
import '../login_screen.dart'; 
import '../funcionario/add_charging_tab.dart';
import '../funcionario/list_chargings_tab.dart';
import '../funcionario/products_tab.dart';

class FuncionarioScreen extends StatefulWidget {
  final User user;
  const FuncionarioScreen({super.key, required this.user});

  @override
  State<FuncionarioScreen> createState() => _FuncionarioScreenState();
}

class _FuncionarioScreenState extends State<FuncionarioScreen> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      AddChargingTab(user: widget.user),
      ListChargingsTab(
        user: widget.user,
        onChargingSelected: (charging) {
          print('Carregamento selecionado: ${charging.description}');
        },
      ),
      ProductsTab(user: widget.user),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionário - Carregamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Adicionar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Carregamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produtos',
          ),
        ],
      ),
    );
  }
}
