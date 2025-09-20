import 'package:flutter/material.dart';
import '../../model/pre_sale.dart';
import '../../services/inspector_service.dart';

class PreSaleDetailScreen extends StatelessWidget {
  final PreSale preSale;
  final int inspectorId;

  const PreSaleDetailScreen({
    super.key,
    required this.preSale,
    required this.inspectorId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pré-venda #${preSale.id}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              "Data:",
              "${preSale.preSaleDate}",
              "Vendedor:",
              preSale.seller.nomeSeller,
            ),
            const SizedBox(height: 20),
            _buildClientCard(),
            const SizedBox(height: 20),
            _buildProductsCard(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showApproveModal(context),
                  icon: const Icon(Icons.check),
                  label: const Text("Aprovar"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _showRejectModal(context),
                  icon: const Icon(Icons.delete),
                  label: const Text("Recusar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(label1, value1),
            const SizedBox(height: 10),
            _buildInfoRow(label2, value2),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dados do Cliente",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoRow("Nome:", preSale.client.name),
            _buildInfoRow("CPF:", preSale.client.cpf),
            _buildInfoRow("Telefone:", preSale.client.phone),
            const SizedBox(height: 10),
            Text(
              "Endereço: ${preSale.client.address.street}, ${preSale.client.address.number}, "
              "${preSale.client.address.city} - ${preSale.client.address.state}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Produtos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...preSale.items.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item.productName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Quantidade: ${item.quantity}"),
                leading: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  void _showRejectModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar recusa"),
        content: const Text("Tem certeza que deseja recusar esta pré-venda?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context); // fecha modal
              try {
                await InspectorService().rejectPreSale(preSale.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pré-venda recusada")),
                );
                Navigator.pop(context, true); // volta e indica atualização
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Erro: $e")));
              }
            },
            child: const Text("Recusar"),
          ),
        ],
      ),
    );
  }

  void _showApproveModal(BuildContext context) {
    String paymentMethod = "CASH";
    int installments = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Aprovar Pré-venda"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: paymentMethod,
              items: const [
                DropdownMenuItem(value: "CASH", child: Text("Dinheiro")),
                DropdownMenuItem(value: "PARCEL", child: Text("Parcelado")),
                DropdownMenuItem(value: "CREDIT", child: Text("Crédito")),
                DropdownMenuItem(value: "DEBIT", child: Text("Débito")),
                DropdownMenuItem(value: "PIX", child: Text("PIX")),
              ],
              onChanged: (val) {
                if (val != null) paymentMethod = val;
              },
              decoration: const InputDecoration(
                labelText: "Método de pagamento",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: installments.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Parcelas"),
              onChanged: (val) => installments = int.tryParse(val) ?? 0,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // fecha modal
              try {
                await InspectorService().approvePreSale(
                  preSaleId: preSale.id!,
                  inspectorId: inspectorId,
                  paymentMethod: paymentMethod,
                  installments: installments,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pré-venda aprovada")),
                );
                Navigator.pop(context, true); // volta e indica atualização
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Erro ao aprovar: $e")));
              }
            },
            child: const Text("Aprovar"),
          ),
        ],
      ),
    );
  }
}
