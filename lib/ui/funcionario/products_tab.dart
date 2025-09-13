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
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum produto disponível'));
        }

        final products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('Marca: ${product.brand} - Qtd: ${product.amount}'),
            );
          },
        );
      },
    );
  }
}
