import 'package:flutter/material.dart';
import '../../../model/dto/inspector_history_pre_sale_dto.dart';
import '../../../services/inspector_service.dart';

class InspectorHistoryPreSalesScreen extends StatelessWidget {
  final int inspectorId;
  const InspectorHistoryPreSalesScreen({super.key, required this.inspectorId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InspectorHistoryPreSaleDto>>(
      future: InspectorService().getHistoryByInspectorId(inspectorId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro: ${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final historyList = snapshot.data ?? [];

        if (historyList.isEmpty) {
          return const Center(
            child: Text("Nenhuma pré-venda encontrada no histórico."),
          );
        }

        // 🔹 Separa as listas por status
        final approvedList = historyList
            .where((item) => item.status.toUpperCase() == 'APROVADA')
            .toList();

        final rejectedList = historyList
            .where((item) => item.status.toUpperCase() == 'RECUSADA')
            .toList();

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Histórico de Vendas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: [
                  Tab(icon: Icon(Icons.check_circle), text: 'Aprovadas'),
                  Tab(icon: Icon(Icons.cancel), text: 'Recusadas'),
                ],
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                _buildList(approvedList, Colors.green, "Nenhuma aprovada."),
                _buildList(rejectedList, Colors.red, "Nenhuma recusada."),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Widget para montar a lista
  Widget _buildList(
    List<InspectorHistoryPreSaleDto> list,
    Color color,
    String emptyMessage,
  ) {
    if (list.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              "Cliente: ${item.clientName}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Data: ${item.preSaleDate}"),
                Text("Total: R\$ ${item.totalPreSale.toStringAsFixed(2)}"),
              ],
            ),
            trailing: Text(
              item.status,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
