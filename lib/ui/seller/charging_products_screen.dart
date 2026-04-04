import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
import '../../model/pre_sale_item.dart';
import '../seller/create_pre_sale_screen.dart';
import '../../services/charging_service.dart';

class ChargingProductsScreen extends StatefulWidget {
  final User user;
  final Charging charging;
  final Map<int, int> selectedProducts;
  final List<PreSaleItem> selectedItems;
  final void Function({
    required int productId,
    required int quantity,
    required String productName,
    required double unitPrice,
  })
  onQuantityChanged;
  final VoidCallback onClearSelection;

  const ChargingProductsScreen({
    super.key,
    required this.user,
    required this.charging,
    required this.selectedProducts,
    required this.selectedItems,
    required this.onQuantityChanged,
    required this.onClearSelection,
  });

  @override
  State<ChargingProductsScreen> createState() => _ChargingProductsScreenState();
}

class _ChargingProductsScreenState extends State<ChargingProductsScreen> {
  late Charging _charging;

  @override
  void initState() {
    super.initState();
    _charging = widget.charging;
  }

  @override
  void didUpdateWidget(covariant ChargingProductsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _charging = widget.charging;
  }

  void _updateProductQuantity({
    required int productId,
    required int quantity,
    required String productName,
    required double unitPrice,
  }) {
    widget.onQuantityChanged(
      productId: productId,
      quantity: quantity,
      productName: productName,
      unitPrice: unitPrice,
    );

    setState(() {});
  }

  Future<void> _reloadCharging() async {
    final updated = await ChargingService().getChargingById(widget.charging.id);

    if (!mounted) return;

    setState(() {
      _charging = updated;
    });
  }

  Future<void> _navigateToCreatePreSale() async {
    if (widget.selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione pelo menos um produto para continuar'),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreatePreSaleScreen(
          user: widget.user,
          charging: _charging,
          selectedItems: List.from(widget.selectedItems),
        ),
      ),
    );

    if (result == true) {
      widget.onClearSelection();
      await _reloadCharging();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pré-venda criada com sucesso! Produtos resetados.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalSelectedQuantity = widget.selectedProducts.values.fold<int>(
      0,
      (sum, quantity) => sum + quantity,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        title: Row(
          children: [
            const Icon(Icons.inventory_2, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${_charging.description} - ${_charging.data}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (totalSelectedQuantity > 0)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                'Itens selecionados: $totalSelectedQuantity',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Expanded(
            child: _charging.chargingItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum produto disponível neste carregamento.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _charging.chargingItems.length,
                    itemBuilder: (context, index) {
                      final item = _charging.chargingItems[index];
                      final quantity =
                          widget.selectedProducts[item.productId] ?? 0;

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.blue,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nameProduct,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Marca: ${item.brand}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "R\$ ${item.priceProduct.toStringAsFixed(2)} • Disponível: ${item.quantity}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: quantity > 0
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: quantity > 0
                                            ? () => _updateProductQuantity(
                                                productId: item.productId,
                                                quantity: quantity - 1,
                                                productName: item.nameProduct,
                                                unitPrice: item.priceProduct,
                                              )
                                            : null,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: quantity > 0
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: quantity > 0
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: quantity < item.quantity
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        onPressed: quantity < item.quantity
                                            ? () => _updateProductQuantity(
                                                productId: item.productId,
                                                quantity: quantity + 1,
                                                productName: item.nameProduct,
                                                unitPrice: item.priceProduct,
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                  if (quantity > 0)
                                    Text(
                                      'Total: R\$ ${(quantity * item.priceProduct).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.selectedItems.isNotEmpty
          ? FloatingActionButton.extended(
              backgroundColor: Colors.green,
              icon: const Icon(Icons.shopping_cart_checkout),
              label: Text("Continuar (${widget.selectedItems.length})"),
              onPressed: _navigateToCreatePreSale,
            )
          : null,
    );
  }
}
