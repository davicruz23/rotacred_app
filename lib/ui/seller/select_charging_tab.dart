import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../services/charging_service.dart';
import '../../model/charging.dart';

class SelectChargingTab extends StatefulWidget {
  final User user;
  final void Function(Charging) onChargingSelected;

  const SelectChargingTab({
    super.key,
    required this.user,
    required this.onChargingSelected,
  });

  @override
  State<SelectChargingTab> createState() => _SelectChargingTabState();
}

class _SelectChargingTabState extends State<SelectChargingTab> {
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
          return Center(child: Text("Erro: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhum carregamento disponível"));
        }

        final list = snapshot.data!;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final charging = list[index];
            return Card(
              child: ListTile(
                title: Text(charging.description),
                subtitle: Text("Data: ${charging.chargingDate}"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // avisa o SellerScreen qual carregamento foi selecionado
                  widget.onChargingSelected(charging);
                },
              ),
            );
          },
        );
      },
    );
  }
}
