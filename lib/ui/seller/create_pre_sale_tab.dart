import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/pre_sale.dart';
import '../../model/pre_sale_item.dart';
import '../../model/client.dart';
import '../../model/address.dart';
import '../../services/pre_sale_service.dart';

class CreatePreSaleTab extends StatefulWidget {
  final User user;
  const CreatePreSaleTab({super.key, required this.user});

  @override
  State<CreatePreSaleTab> createState() => _CreatePreSaleTabState();
}

class _CreatePreSaleTabState extends State<CreatePreSaleTab> {
  final PreSaleService _preSaleService = PreSaleService();
  bool _isLoading = false;

  // Simulação de produtos selecionados (id do produto -> quantidade)
  final Map<int, int> _selectedProducts = {
    1: 2,
    2: 1,
  };

  final client = Client(
    id: 0,
    name: 'Cliente Teste',
    cpf: '00000000000',
    phone: '999999999',
    address: Address(
      id: 0,
      state: 'RN',
      city: 'Natal',
      street: 'Rua Teste',
      number: '123',
      zipCode: '59000-000',
      complement: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Iniciar Pré-Venda'),
              onPressed: _sendPreSale,
            ),
    );
  }

  Future<void> _sendPreSale() async {
    if (_selectedProducts.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final items = _selectedProducts.entries
          .map((e) => PreSaleItem(productId: e.key, quantity: e.value))
          .toList();

      final preSale = PreSale(
        preSaleDate: DateTime.now(),
        sellerId: 1,
        client: client,
        products: items,
        chargingId: 1,
      );

      await _preSaleService.createPreSale(preSale);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pré-venda criada com sucesso!')),
      );
      setState(() {
        _selectedProducts.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar pré-venda: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
