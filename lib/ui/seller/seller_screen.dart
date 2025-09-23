import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
import '../login_screen.dart';
import 'select_charging_tab.dart';
import 'charging_products_screen.dart';
import 'create_pre_sale_screen.dart';

class SellerScreen extends StatefulWidget {
  final User user;
  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  int _currentIndex = 0;
  Charging? _selectedCharging;

  void _onChargingSelected(Charging charging) {
    setState(() {
      _selectedCharging = charging;
      _currentIndex = 1;
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
    final tabs = <Widget>[
      SelectChargingTab(
        user: widget.user,
        onChargingSelected: _onChargingSelected,
      ),
      _selectedCharging != null
          ? ChargingProductsScreen(
              user: widget.user,
              charging: _selectedCharging!,
            )
          : _noChargingSelectedWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                widget.user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Vendedor - ${widget.user.name}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue.shade700,
        onTap: (index) {
          if (index == 1 && _selectedCharging == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selecione um carregamento primeiro.'),
              ),
            );
            setState(() => _currentIndex = 0);
            return;
          }
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Carregamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Produtos',
          ),
        ],
      ),
      floatingActionButton: _selectedCharging != null
          ? FloatingActionButton.extended(
              backgroundColor: Colors.green,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Iniciar Pré-venda'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreatePreSaleScreen(
                      user: widget.user,
                      charging: _selectedCharging!,
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }

  Widget _noChargingSelectedWidget() {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 60, color: Colors.blue.shade300),
              const SizedBox(height: 16),
              const Text(
                'Nenhum carregamento selecionado.\nEscolha um carregamento na aba Carregamentos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
