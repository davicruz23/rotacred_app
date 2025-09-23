import 'package:flutter/material.dart';
import '../../services/product_service.dart';
import '../../model/product.dart';
import '../../model/user.dart';

class ProductsTab extends StatefulWidget {
  final User user;
  const ProductsTab({super.key, required this.user});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: ${snapshot.error}',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(Icons.inventory_2, color: Colors.blue, size: 28),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  "Marca: ${product.brand}\nQuantidade em estoque: ${product.amount}",
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
