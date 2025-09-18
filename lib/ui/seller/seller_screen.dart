import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
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

  // callback passado para SelectChargingTab
  void _onChargingSelected(Charging charging) {
    setState(() {
      _selectedCharging = charging;
      _currentIndex = 1; // muda pra aba Produtos (Pré-venda)
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      // Aba 0: lista de carregamentos (quando tocar em um charging, chama _onChargingSelected)
      SelectChargingTab(
        user: widget.user,
        onChargingSelected: _onChargingSelected,
      ),

      // Aba 1: produtos do carregamento selecionado (ou placeholder se nada selecionado)
      _selectedCharging != null
          ? ChargingProductsScreen(user: widget.user, charging: _selectedCharging!)
          : _noChargingSelectedWidget(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Vendedor')),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Carregamentos'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Produtos'),
        ],
        onTap: (index) {
          // se o usuário tentar abrir aba Produtos sem selecionar um carregamento, avisar
          if (index == 1 && _selectedCharging == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selecione um carregamento primeiro.')),
            );
            setState(() => _currentIndex = 0);
            return;
          }
          setState(() => _currentIndex = index);
        },
      ),
      // opcional: botão flutuante global que abre a tela de criar pré-venda com o charging selecionado
      floatingActionButton: _selectedCharging != null
          ? FloatingActionButton.extended(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.info_outline, size: 48),
          SizedBox(height: 12),
          Text('Nenhum carregamento selecionado.\nEscolha um carregamento na aba Carregamentos.',
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
