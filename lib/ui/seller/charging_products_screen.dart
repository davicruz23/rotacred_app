import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
import '../seller/create_pre_sale_screen.dart';
import '../../services/charging_service.dart';

class ChargingProductsScreen extends StatefulWidget {
  final User user;
  final Charging charging;
  const ChargingProductsScreen({
    super.key,
    required this.user,
    required this.charging,
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

  Future<void> _reloadCharging() async {
    final updated = await ChargingService().getChargingById(
      widget.charging.id!,
    );
    setState(() => _charging = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                widget.user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _charging.description,
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
      body: _charging.chargingItems.isEmpty
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
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _charging.chargingItems.length,
              itemBuilder: (context, index) {
                final item = _charging.chargingItems[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      item.nameProduct,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Marca: ${item.brand} | Qtd disponível: ${item.quantity}",
                    ),
                    leading: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: const Icon(Icons.shopping_cart),
        label: const Text("Iniciar Pré-venda"),
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CreatePreSaleScreen(user: widget.user, charging: _charging),
            ),
          );

          if (created == true) {
            await _reloadCharging();
          }
        },
      ),
    );
  }
}
