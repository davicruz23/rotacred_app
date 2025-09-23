import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
import '../../services/charging_service.dart';

class SelectChargingTab extends StatefulWidget {
  final User user;
  final Function(Charging) onChargingSelected;

  const SelectChargingTab({
    super.key,
    required this.user,
    required this.onChargingSelected,
  });

  @override
  State<SelectChargingTab> createState() => _SelectChargingTabState();
}

class _SelectChargingTabState extends State<SelectChargingTab> {
  late Future<List<Charging>> _chargings;

  @override
  void initState() {
    super.initState();
    _chargings = ChargingService().getChargings(); // pega carregamentos do serviço
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
          return const Center(
            child: Text(
              'Nenhum carregamento disponível',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        final chargings = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: chargings.length,
          itemBuilder: (context, index) {
            final charging = chargings[index];

            return GestureDetector(
              onTap: () => widget.onChargingSelected(charging),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(Icons.local_shipping, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              charging.description ?? 'Sem descrição',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Itens: ${charging.chargingItems.length}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              'Data: ${charging.chargingDate}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
