import 'package:flutter/material.dart';
import '../../services/charging_service.dart';
import '../../model/charging.dart';
import '../../model/user.dart';

class ListChargingsTab extends StatefulWidget {
  final User user;
  final Function(Charging) onChargingSelected;

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
          return Center(
            child: Text(
              'Erro ao carregar: ${snapshot.error}',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum carregamento encontrado',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        final chargings = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: chargings.length,
          itemBuilder: (context, index) {
            final charging = chargings[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ExpansionTile(
                leading: const Icon(Icons.local_shipping, color: Colors.blueAccent),
                title: Text(
                  charging.description ?? 'Sem descrição',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Data: ${charging.chargingDate} • Itens: ${charging.chargingItems.length}',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                children: [
                  ...charging.chargingItems.map(
                    (item) => ListTile(
                      leading: const Icon(Icons.inventory_2, color: Colors.grey),
                      title: Text(item.nameProduct),
                      subtitle: Text('Disponivel: ${item.quantity}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text(
                          'Selecionar este carregamento',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => widget.onChargingSelected(charging),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
