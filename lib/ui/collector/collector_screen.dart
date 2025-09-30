import 'package:flutter/material.dart';
import '../../model/dto/sale_collector_dto.dart';
import '../../services/collector_service.dart';
import '../../model/user.dart';
import '../login_screen.dart';

class CollectorScreen extends StatefulWidget {
  final User user;
  const CollectorScreen({super.key, required this.user});

  @override
  State<CollectorScreen> createState() => _CollectorScreenState();
}

class _CollectorScreenState extends State<CollectorScreen> {
  bool _isLoading = true;
  List<SaleCollectorDTO> _sales = [];
  int? _collectorId;

  @override
  void initState() {
    super.initState();
    _fetchCollectorSales();
  }

  Future<void> _fetchCollectorSales() async {
    setState(() => _isLoading = true);
    try {
      final collector = await CollectorService().getCollectorByUserId(
        widget.user.id,
      );
      final sales = await CollectorService().getSalesForCollector(
        collector.idCollector,
      );

      setState(() {
        _collectorId = collector.idCollector;
        _sales = sales;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao buscar vendas: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _markAsPaid(int installmentId) async {
    try {
      await CollectorService().paySale(installmentId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pagamento marcado com sucesso ✅")),
      );

      // Recarrega as vendas para refletir o novo status
      await _fetchCollectorSales();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao marcar pagamento: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    void _logout() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name} Cobrador"),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sales.isEmpty
          ? const Center(child: Text("Nenhuma venda encontrada"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ExpansionTile(
                    title: Text(
                      "${sale.client.name} - ${sale.saleDate.toLocal().toString().split(' ')[0]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Produtos: ${sale.products.map((p) => p.nameProduct).join(', ')}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    childrenPadding: const EdgeInsets.all(12),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CPF: ${sale.client.cpf}"),
                          Text("Telefone: ${sale.client.phone}"),
                          Text(
                            "Endereço: ${sale.client.address.street}, nº ${sale.client.address.number}, "
                            "${sale.client.address.city} / ${sale.client.address.zipCode} "
                            "${sale.client.address.complement.isNotEmpty ? '- ${sale.client.address.complement}' : ''}",
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Parcelas",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          ...sale.installments.asMap().entries.map((entry) {
                            final index = entry.key;
                            final inst = entry.value;

                            // Verifica se todas as parcelas anteriores estão pagas
                            final canPay =
                                index == 0 ||
                                sale.installments
                                    .sublist(0, index)
                                    .every((prev) => prev.paid);

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Vencimento: ${inst.dueDate.toLocal().toString().split(' ')[0]} - R\$ ${inst.amount}",
                              ),
                              trailing: inst.paid
                                  ? const Icon(
                                      Icons.attach_money,
                                      color: Colors.green,
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.attach_money,
                                        color: Color.fromARGB(255, 235, 2, 2),
                                      ),
                                      tooltip: canPay
                                          ? "Marcar como pago"
                                          : "Pague as parcelas anteriores primeiro",
                                      onPressed: canPay
                                          ? () async {
                                              await _markAsPaid(inst.id);
                                            }
                                          : null, // desabilita se não puder pagar
                                    ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
