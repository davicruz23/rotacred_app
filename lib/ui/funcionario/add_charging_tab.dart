import 'package:flutter/material.dart';
import '../../model/product.dart';
import '../../model/user.dart';
import '../../services/product_service.dart';
import '../../services/charging_service.dart';

class AddChargingTab extends StatefulWidget {
  final User user;
  const AddChargingTab({super.key, required this.user});

  @override
  State<AddChargingTab> createState() => _AddChargingTabState();
}

class _AddChargingTabState extends State<AddChargingTab> {
  late Future<List<Product>> _products;
  final ProductService _productService = ProductService();
  final ChargingService _chargingService = ChargingService();
  final Map<int, int> _selectedProducts = {}; // productId -> quantity

  @override
  void initState() {
    super.initState();
    _products = _productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<Product>>(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum produto disponível'));
            }

            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final quantity = _selectedProducts[product.id] ?? 0;
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Marca: ${product.brand} - Qtd: ${product.amount}'),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 0) _selectedProducts[product.id] = quantity - 1;
                            });
                          },
                        ),
                        Text(quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _selectedProducts[product.id] = quantity + 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            label: const Text('Enviar Carregamento'),
            icon: const Icon(Icons.send),
            onPressed: _selectedProducts.isEmpty ? null : _sendCharging,
          ),
        ),
      ],
    );
  }

  Future<void> _sendCharging() async {
    final items = _selectedProducts.entries
        .map((e) => {'productId': e.key, 'quantity': e.value})
        .toList();

    try {
      await _chargingService.sendCharging(
        description: 'Carregamento do dia!',
        date: DateTime.now().toIso8601String(),
        items: items,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carregamento enviado com sucesso!')),
      );
      setState(() {
        _selectedProducts.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar: $e')),
      );
    }
  }
}
