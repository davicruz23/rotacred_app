import 'package:flutter/material.dart';
import '../../services/charging_service.dart';
import '../../model/charging.dart';
import '../../model/user.dart';

class ListChargingsTab extends StatefulWidget {
  final User user;
  final Function(Charging) onChargingSelected; // callback quando escolher o carregamento

  const ListChargingsTab({
    super.key,
    required this.user,
    required this.onChargingSelected,
  });

  @override
  State<ListChargingsTab> createState() => _ListChargingsTabState();
}

class _ListChargingsTabState extends State<ListChargingsTab> {
  final ChargingService _chargingService = ChargingService();
  late Future<List<Charging>> _chargings;

  @override
  void initState() {
    super.initState();
    _chargings = _chargingService.getChargings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Charging>>(
      future: _chargings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum carregamento encontrado'));
        }

        final chargings = snapshot.data!;
        return ListView(
          children: chargings.map((charging) {
            return ExpansionTile(
              title: Text(charging.description ?? 'Sem descrição'),
              subtitle: Text(
                'Data: ${charging.chargingDate}/ - Total itens: ${charging.chargingItems.length}',
              ),
              children: [
                ...charging.chargingItems.map((item) => ListTile(
                      title: Text('Produto ID: ${item.productId}'),
                      subtitle: Text('Quantidade: ${item.quantity}'),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Selecionar este carregamento'),
                    onPressed: () => widget.onChargingSelected(charging),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
