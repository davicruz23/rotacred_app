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
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                preSale.seller.nomeSeller.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pré-venda #${preSale.id}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _infoCard("Data:", "${preSale.preSaleDate}", "Vendedor:", preSale.seller.nomeSeller),
            const SizedBox(height: 16),
            _clientCard(),
            const SizedBox(height: 16),
            _productsCard(),
            const SizedBox(height: 30),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label1, String value1, String label2, String value2) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _infoRow(label1, value1),
            const SizedBox(height: 10),
            _infoRow(label2, value2),
          ],
        ),
      ),
    );
  }

  Widget _clientCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dados do Cliente", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _infoRow("Nome:", preSale.client.name),
            _infoRow("CPF:", preSale.client.cpf),
            _infoRow("Telefone:", preSale.client.phone),
            const SizedBox(height: 8),
            Text(
              "Endereço: ${preSale.client.address.street}, ${preSale.client.address.number}, "
              "${preSale.client.address.city} - ${preSale.client.address.state}",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productsCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Produtos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ...preSale.items.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                title: Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text("Quantidade: ${item.quantity}"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text("Aprovar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () => _showApproveModal(context),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.close, color: Colors.white),
          label: const Text("Recusar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () => _showRejectModal(context),
        ),
      ],
    );
  }

  void _showRejectModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [Icon(Icons.warning, color: Colors.red), SizedBox(width: 8), Text("Confirmar recusa")],
        ),
        content: const Text("Tem certeza que deseja recusar esta pré-venda?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await InspectorService().rejectPreSale(preSale.id!);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pré-venda recusada")));
                Navigator.pop(context, true);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro: $e")));
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [Icon(Icons.check_circle, color: Colors.green), SizedBox(width: 8), Text("Aprovar venda")],
        ),
        content: SingleChildScrollView(
          child: Column(
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
                onChanged: (val) => paymentMethod = val ?? "CASH",
                decoration: const InputDecoration(labelText: "Método de pagamento"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: installments.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Parcelas (se houver)"),
                onChanged: (val) => installments = int.tryParse(val) ?? 0,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await InspectorService().approvePreSale(
                  preSaleId: preSale.id!,
                  inspectorId: inspectorId,
                  paymentMethod: paymentMethod,
                  installments: installments,
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pré-venda aprovada")));
                Navigator.pop(context, true);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao aprovar: $e")));
              }
            },
            child: const Text("Aprovar"),
          ),
        ],
      ),
    );
  }
}
