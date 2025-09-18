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
      appBar: AppBar(title: Text("Produtos - ${_charging.description}")),
      body: ListView.builder(
        itemCount: _charging.chargingItems.length,
        itemBuilder: (context, index) {
          final item = _charging.chargingItems[index];
          return ListTile(
            title: Text(item.nameProduct),
            subtitle: Text(
              "Marca: ${item.brand} | Qtd disponível: ${item.quantity}",
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
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
