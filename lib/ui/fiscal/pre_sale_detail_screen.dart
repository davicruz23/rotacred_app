import 'package:flutter/material.dart';
import '../../model/pre_sale.dart';
import '../../services/inspector_service.dart';
import 'package:geolocator/geolocator.dart';

class PreSaleDetailScreen extends StatelessWidget {
  final PreSale preSale;
  final int inspectorId;

  const PreSaleDetailScreen({
    super.key,
    required this.preSale,
    required this.inspectorId,
  });

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está ativo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desativado');
    }

    // Verifica e solicita permissão
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissão de localização negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permissão de localização negada permanentemente');
    }

    // ✅ Nova forma de obter a posição
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pré-venda #${preSale.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
            // Informações básicas
            _highlightInfoCard(
              "Data:",
              "${preSale.preSaleDate}",
              "Vendedor:",
              preSale.seller.nomeSeller,
            ),

            const SizedBox(height: 20),

            // Destaque: Cliente
            _highlightCard(
              icon: Icons.person,
              title: "Dados do Cliente",
              children: [
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
            const SizedBox(height: 20),

            // Destaque: Produtos
            _highlightCard(
              icon: Icons.shopping_cart,
              title: "Produtos",
              children: preSale.items
                  .map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        item.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      trailing: Text(
                        "x${item.quantity}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 30),

            // Botões de ação
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  // Cartão básico para info rápida
  // Widget _infoCard(String label1, String value1, String label2, String value2) {
  //   return Card(
  //     elevation: 3,
  //     shadowColor: Colors.black12,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           _infoRow(label1, value1),
  //           const SizedBox(height: 8),
  //           _infoRow(label2, value2),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Cartão de destaque (cliente ou produtos)
  Widget _highlightCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1.2),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _highlightInfoCard(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoRow(label1, value1),
            const SizedBox(height: 8),
            _infoRow(label2, value2),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          onPressed: () => _showApproveModal(context),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.close, color: Colors.white),
          label: const Text("Recusar"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
          children: const [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text("Confirmar recusa"),
          ],
        ),
        content: const Text("Tem certeza que deseja recusar esta pré-venda?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await InspectorService().rejectPreSale(preSale.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pré-venda recusada")),
                );
                Navigator.pop(context, true);
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
    double? cashPaid;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text("Aprovar venda"),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: paymentMethod,
                    items: const [
                      DropdownMenuItem(value: "CASH", child: Text("Dinheiro")),
                      DropdownMenuItem(
                        value: "PARCEL",
                        child: Text("Parcelado"),
                      ),
                      DropdownMenuItem(value: "CREDIT", child: Text("Crédito")),
                      DropdownMenuItem(value: "DEBIT", child: Text("Débito")),
                      DropdownMenuItem(value: "PIX", child: Text("PIX")),
                    ],
                    onChanged: (val) =>
                        setState(() => paymentMethod = val ?? "CASH"),
                    decoration: const InputDecoration(
                      labelText: "Método de pagamento",
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (paymentMethod == "CASH") ...[
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Valor pago à vista",
                        prefixText: "R\$ ",
                      ),
                      onChanged: (val) {
                        setState(
                          () => cashPaid = double.tryParse(
                            val.replaceAll(',', '.'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],

                  TextFormField(
                    initialValue: installments.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Parcelas (se houver)",
                    ),
                    onChanged: (val) =>
                        setState(() => installments = int.tryParse(val) ?? 0),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  try {
                    // ✅ 1. Captura localização
                    final pos = await _getCurrentLocation();

                    // ✅ 2. Envia tudo ao backend
                    await InspectorService().approvePreSale(
                      preSaleId: preSale.id!,
                      inspectorId: inspectorId,
                      paymentMethod: paymentMethod,
                      installments: installments,
                      cashPaid: cashPaid,
                      latitude: pos.latitude,
                      longitude: pos.longitude,
                    );

                    // ✅ 3. Fecha o diálogo só depois do sucesso
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pré-venda aprovada ✅")),
                    );

                    Navigator.pop(context, true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erro ao aprovar: $e")),
                    );
                  }
                },
                child: const Text("Aprovar"),
              ),
            ],
          );
        },
      ),
    );
  }
}
