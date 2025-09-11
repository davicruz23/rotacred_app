import 'package:flutter/material.dart';
import 'package:rotacred_app/model/product.dart';
import 'package:rotacred_app/services/product_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _products;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _products = _productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: CircleAvatar(child: Text(product.name[0])), // primeira letra do nome
                title: Text(product.name), // nome do produto
                subtitle: Text(
                  'Marca: ${product.brand} - Qtd: ${product.amount} - R\$ ${product.value.toStringAsFixed(2)}',
                ), // marca, quantidade e valor
              );
            },
          );
        },
      ),
    );
  }
}
