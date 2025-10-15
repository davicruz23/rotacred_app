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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            const Icon(Icons.bolt, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Carregamentos',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            // child: Row(
            //   children: [
            //     const Icon(Icons.person, color: Colors.white70),
            //     const SizedBox(width: 4),
            //     // Text(
            //     //   widget.user.name ?? 'Usuário',
            //     //   style: const TextStyle(color: Colors.white70),
            //     // ),
            //   ],
            // ),
          ),
        ],
      ),
      body: FutureBuilder<List<Charging>>(
        future: _chargings,
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
                  const SizedBox(height: 12),
                  Text(
                    'Erro ao carregar dados',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum carregamento encontrado 🚚',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final chargings = snapshot.data!;

          return RefreshIndicator(
            color: Colors.blueAccent,
            onRefresh: () async {
              setState(() {
                _chargings = _chargingService.getChargings();
              });
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: chargings.length,
              itemBuilder: (context, index) {
                final charging = chargings[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
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
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    iconColor: Colors.blueAccent,
                    collapsedIconColor: Colors.blueAccent,
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.1),
                      child: const Icon(
                        Icons.local_shipping,
                        color: Colors.blueAccent,
                      ),
                    ),
                    title: Text(
                      charging.description ?? 'Sem descrição',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Data: ${charging.chargingDate} • Itens: ${charging.chargingItems.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      ...charging.chargingItems.map(
                        (item) => ListTile(
                          leading: const Icon(
                            Icons.inventory_2,
                            color: Colors.grey,
                          ),
                          title: Text(item.nameProduct),
                          subtitle: Text('Disponível: ${item.quantity}'),
                        ),
                      ),
                      const Divider(thickness: 0.7),
                      SizedBox(
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
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () => widget.onChargingSelected(charging),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
