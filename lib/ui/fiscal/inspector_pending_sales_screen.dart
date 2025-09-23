import 'package:flutter/material.dart';
import '../../model/pre_sale.dart';
import '../../services/inspector_service.dart';
import 'pre_sale_detail_screen.dart';

class InspectorPendingPreSalesScreen extends StatefulWidget {
  final int inspectorId;
  const InspectorPendingPreSalesScreen({super.key, required this.inspectorId});

  @override
  State<InspectorPendingPreSalesScreen> createState() =>
      _InspectorPendingPreSalesScreenState();
}

class _InspectorPendingPreSalesScreenState
    extends State<InspectorPendingPreSalesScreen> {
  late Future<List<PreSale>> _futurePreSales;

  @override
  void initState() {
    super.initState();
    _loadPreSales();
  }

  void _loadPreSales() {
    _futurePreSales = InspectorService().getPendingPreSales(widget.inspectorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Pré-vendas pendentes"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<PreSale>>(
        future: _futurePreSales,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Nenhuma pré-venda pendente",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final preSales = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: preSales.length,
            itemBuilder: (context, index) {
              final preSale = preSales[index];

              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PreSaleDetailScreen(
                        preSale: preSale,
                        inspectorId: widget.inspectorId,
                      ),
                    ),
                  );

                  if (result == true) {
                    setState(() => _loadPreSales());
                  }
                },
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.black26,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.blue.shade50,
                          child: const Icon(
                            Icons.assignment_outlined,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pré-venda #${preSale.id}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Cliente: ${preSale.client.name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Vendedor: ${preSale.seller.nomeSeller}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
