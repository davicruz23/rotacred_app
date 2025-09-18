import 'package:flutter/material.dart';
import '../../model/pre_sale.dart';
import '../../services/inspector_service.dart';
import 'pre_sale_detail_screen.dart';

class InspectorPendingPreSalesScreen extends StatefulWidget {
  final int inspectorId;
  const InspectorPendingPreSalesScreen({super.key, required this.inspectorId});

  @override
  State<InspectorPendingPreSalesScreen> createState() => _InspectorPendingPreSalesScreenState();
}

class _InspectorPendingPreSalesScreenState extends State<InspectorPendingPreSalesScreen> {
  late Future<List<PreSale>> _futurePreSales;

  @override
  void initState() {
    super.initState();
    _futurePreSales = InspectorService().getPendingPreSales(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pré-vendas pendentes")),
      body: FutureBuilder<List<PreSale>>(
        future: _futurePreSales,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma pré-venda pendente"));
          }

          final preSales = snapshot.data!;

          return ListView.builder(
            itemCount: preSales.length,
            itemBuilder: (context, index) {
              final preSale = preSales[index];
              return ListTile(
                title: Text("Pré-venda #${preSale.id}"),
                subtitle: Text("Cliente: ${preSale.client.name}"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PreSaleDetailScreen(preSaleId: preSale.id!),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
