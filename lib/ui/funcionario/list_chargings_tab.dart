import 'package:flutter/material.dart';
import '../../services/charging_service.dart';
import '../../model/charging.dart';
import '../../model/user.dart';

class ListChargingsTab extends StatefulWidget {
  final User user;
  const ListChargingsTab({super.key, required this.user});

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
        return ListView.builder(
          itemCount: chargings.length,
          itemBuilder: (context, index) {
            final charging = chargings[index];
            return ListTile(
              title: Text(charging.description ?? 'Sem descrição'),
              subtitle: Text(
                'Data: ${charging.date != null ? "${charging.date!.day}/${charging.date!.month}/${charging.date!.year}" : 'Sem data'}',
              ),
              trailing: Text('${charging.items.length} itens'),
            );
          },
        );
      },
    );
  }
}
