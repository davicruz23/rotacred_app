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
  final Map<int, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    _products = _productService.getProducts();
  }

  @override
  void dispose() {
    // Limpa os controllers
    _quantityControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateProductQuantity(int productId, int newQuantity, int maxStock) {
    setState(() {
      if (newQuantity <= 0) {
        _selectedProducts.remove(productId);
        _quantityControllers[productId]?.text = '';
      } else if (newQuantity <= maxStock) {
        _selectedProducts[productId] = newQuantity;
        _quantityControllers[productId]?.text = newQuantity.toString();
      }
      // Se newQuantity > maxStock, não faz nada (bloqueado)
    });
  }

  void _handleQuantityInput(int productId, String value, int maxStock) {
    if (value.isEmpty) {
      setState(() {
        _selectedProducts.remove(productId);
      });
      return;
    }

    final quantity = int.tryParse(value) ?? 0;

    if (quantity > maxStock) {
      // Mostra mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quantidade não pode ser maior que $maxStock'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      // Restaura o valor anterior
      final previousQuantity = _selectedProducts[productId] ?? 0;
      _quantityControllers[productId]?.text = previousQuantity > 0
          ? previousQuantity.toString()
          : '';
      return;
    }

    _updateProductQuantity(productId, quantity, maxStock);
  }

  Widget _buildQuantityInput(Product product) {
    final quantity = _selectedProducts[product.id] ?? 0;

    // Inicializa o controller se não existir
    if (!_quantityControllers.containsKey(product.id)) {
      _quantityControllers[product.id] = TextEditingController(
        text: quantity > 0 ? quantity.toString() : '',
      );
    }

    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: quantity > 0 ? Colors.blue.shade300 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          // Botão diminuir
          IconButton(
            icon: Icon(
              Icons.remove,
              size: 18,
              color: quantity > 0 ? Colors.red : Colors.grey,
            ),
            padding: const EdgeInsets.all(4),
            onPressed: quantity > 0
                ? () => _updateProductQuantity(
                    product.id,
                    quantity - 1,
                    product.amount,
                  )
                : null,
          ),

          // Campo de input
          Expanded(
            child: TextField(
              controller: _quantityControllers[product.id],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: '0',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              onChanged: (value) =>
                  _handleQuantityInput(product.id, value, product.amount),
            ),
          ),

          // Botão aumentar
          IconButton(
            icon: Icon(
              Icons.add,
              size: 18,
              color: quantity < product.amount ? Colors.green : Colors.grey,
            ),
            padding: const EdgeInsets.all(4),
            onPressed: quantity < product.amount
                ? () => _updateProductQuantity(
                    product.id,
                    quantity + 1,
                    product.amount,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  int get _totalSelectedProducts {
    return _selectedProducts.values.fold(0, (sum, quantity) => sum + quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header com resumo
        if (_selectedProducts.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.lightBlue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(color: Colors.blue.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.blue,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_selectedProducts.length} produto(s) selecionado(s)',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  'Total: $_totalSelectedProducts un',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

        // Lista de produtos
        Padding(
          padding: EdgeInsets.only(top: _selectedProducts.isNotEmpty ? 70 : 0),
          child: FutureBuilder<List<Product>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Erro ao carregar produtos',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum produto disponível',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final products = snapshot.data!;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final quantity = _selectedProducts[product.id] ?? 0;

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: quantity > 0
                            ? LinearGradient(
                                colors: [Colors.blue.shade50, Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        border: quantity > 0
                            ? Border.all(color: Colors.blue.shade200, width: 1)
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Ícone do produto
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: quantity > 0
                                    ? Colors.blue.shade100
                                    : Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_bag,
                                color: quantity > 0
                                    ? Colors.blue.shade600
                                    : Colors.grey.shade600,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Informações do produto
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.brand,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory_2,
                                        size: 14,
                                        color: Colors.green.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Estoque: ${product.amount}',
                                        style: TextStyle(
                                          color: Colors.green.shade600,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Controles de quantidade
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildQuantityInput(product),
                                const SizedBox(height: 4),
                                if (quantity > 0)
                                  Text(
                                    'Selecionado: $quantity',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
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
        ),

        // Botão flutuante
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _selectedProducts.isEmpty ? 0 : 56,
            child: _selectedProducts.isEmpty
                ? const SizedBox.shrink()
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      shadowColor: Colors.blueAccent.withOpacity(0.3),
                    ),
                    icon: const Icon(Icons.send, size: 24),
                    label: const Text(
                      'Enviar Carregamento',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _sendCharging,
                  ),
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
        SnackBar(
          content: const Text('Carregamento enviado com sucesso!'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      // Limpa a seleção
      setState(() {
        _selectedProducts.clear();
        _quantityControllers.forEach((key, controller) {
          controller.text = '';
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}
