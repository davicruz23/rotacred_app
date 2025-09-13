import 'package:flutter/material.dart';
import '../../model/user.dart';
import './list_product_tab.dart';
import './create_pre_sale_tab.dart';

class SellerScreen extends StatefulWidget {
  final User user;
  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabs.addAll([
      ListProductsTab(user: widget.user),
      CreatePreSaleTab(user: widget.user),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendedor')),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Produtos'),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), label: 'Pré-venda'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
