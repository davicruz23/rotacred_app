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

  int _currentPage = 0;
  final int _pageSize = 10;

  late Future<Map<String, dynamic>> _pagedProducts;

  @override
  void initState() {
    super.initState();
    _pagedProducts = _productService.getProductsPaged(
      page: _currentPage,
      size: _pageSize,
    );
  }

  void _loadPage(int newPage) {
    setState(() {
      _currentPage = newPage;
      _pagedProducts = _productService.getProductsPaged(
        page: _currentPage,
        size: _pageSize,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: const Color(0xFFF8F9FC),
      child: FutureBuilder<Map<String, dynamic>>(
        future: _pagedProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'Erro ao carregar produtos',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
                ],
              ),
            );
          } else if (!snapshot.hasData ||
              (snapshot.data!['content'] as List).isEmpty) {
            return const Center(
              child: Text(
                'Nenhum produto disponível 🏷️',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final products = snapshot.data!['content'] as List<Product>;
          final totalPages = snapshot.data!['totalPages'];
          final currentPage = snapshot.data!['pageNumber'];
          final totalElements = snapshot.data!['totalElements'];

          return Column(
            children: [
              // Cabeçalho bonito
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.inventory_2,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Produtos em Estoque',
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '$totalElements itens',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Lista
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Produto: ${product.name} (${product.brand})',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.blueAccent.withOpacity(0.1),
                            child: const Icon(
                              Icons.inventory,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "Marca: ${product.brand}\nQuantidade: ${product.amount}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Paginação
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: currentPage > 0
                          ? () => _loadPage(currentPage - 1)
                          : null,
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      label: const Text('Anterior'),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Página ${currentPage + 1} de $totalPages',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: currentPage < totalPages - 1
                          ? () => _loadPage(currentPage + 1)
                          : null,
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      label: const Text('Próxima'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
