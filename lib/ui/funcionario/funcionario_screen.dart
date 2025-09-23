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
        },
      ),
      ProductsTab(user: widget.user),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Funcionário',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: tabs[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Adicionar'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Carregamentos'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Produtos'),
        ],
      ),
    );
  }
}
