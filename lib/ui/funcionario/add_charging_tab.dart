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
              return Center(
                child: Text(
                  'Erro: ${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum produto disponível',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            final products = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final quantity = _selectedProducts[product.id] ?? 0;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.shopping_bag, color: Colors.blue),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${product.brand} • Estoque: ${product.amount}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (quantity > 0)
                                  _selectedProducts[product.id] = quantity - 1;
                              });
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedProducts[product.id] = quantity + 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            icon: const Icon(Icons.send, color: Colors.white),
            label: const Text(
              'Enviar Carregamento',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao enviar: $e')));
    }
  }
}
