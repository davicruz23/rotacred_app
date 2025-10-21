import 'package:flutter/material.dart';
import '../../model/pre_sale.dart';
import '../../services/inspector_service.dart';
import 'package:geolocator/geolocator.dart';

class PreSaleDetailScreen extends StatefulWidget {
  final PreSale preSale;
  final int inspectorId;

  const PreSaleDetailScreen({
    super.key,
    required this.preSale,
    required this.inspectorId,
  });

  @override
  State<PreSaleDetailScreen> createState() => _PreSaleDetailScreenState();
}

class _PreSaleDetailScreenState extends State<PreSaleDetailScreen> {
  bool _productsExpanded = true; // Controla se a sanfona está aberta ou fechada

  // Método para calcular o valor total
  double get _totalValue {
    return widget.preSale.items.fold(
      0.0,
      (total, item) => total + (item.quantity * item.unitPrice),
    );
  }

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
                widget.preSale.seller.nomeSeller.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pré-venda #${widget.preSale.id}',
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
              "${widget.preSale.preSaleDate}",
              "Vendedor:",
              widget.preSale.seller.nomeSeller,
            ),

            const SizedBox(height: 20),

            // Destaque: Cliente
            _highlightCard(
              icon: Icons.person,
              title: "Dados do Cliente",
              children: [
                _infoRow("Nome:", widget.preSale.client.name),
                _infoRow("CPF:", widget.preSale.client.cpf),
                _infoRow("Telefone:", widget.preSale.client.phone),
                const SizedBox(height: 8),
                Text(
                  "Endereço: ${widget.preSale.client.address.street}, ${widget.preSale.client.address.number}, "
                  "${widget.preSale.client.address.city} - ${widget.preSale.client.address.state}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Destaque: Produtos - AGORA COM SANFONA
            _highlightProductsCard(),

            const SizedBox(height: 30),

            // Botões de ação
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _highlightProductsCard() {
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
            // Cabeçalho clicável da sanfona
            InkWell(
              onTap: () {
                setState(() {
                  _productsExpanded = !_productsExpanded;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  const Text(
                    "Produtos Selecionados",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _productsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blueAccent,
                    size: 24,
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1.2),

            // Conteúdo da sanfona (só mostra quando expandido)
            if (_productsExpanded) ...[
              const SizedBox(height: 8),

              // Lista de produtos
              ...widget.preSale.items.map(
                (item) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Ícone do produto
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.blue.shade600,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "Quantidade: ${item.quantity}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "R\$ ${item.unitPrice.toStringAsFixed(2)} un",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Valor total do item
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          "R\$ ${(item.quantity * item.unitPrice).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],

            // Linha do valor total (sempre visível)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Valor Total:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    "R\$ ${_totalValue.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cartão de destaque (cliente)
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
                await InspectorService().rejectPreSale(widget.preSale.id!);
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
    bool _isApproving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Título com ícone e estilo
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Aprovar venda",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Método de pagamento
                    DropdownButtonFormField<String>(
                      initialValue: paymentMethod,
                      items: const [
                        DropdownMenuItem(
                          value: "CASH",
                          child: Text("Dinheiro"),
                        ),
                        DropdownMenuItem(
                          value: "PARCEL",
                          child: Text("Parcelado"),
                        ),
                        DropdownMenuItem(
                          value: "CREDIT",
                          child: Text("Crédito"),
                        ),
                        DropdownMenuItem(value: "DEBIT", child: Text("Débito")),
                        DropdownMenuItem(value: "PIX", child: Text("PIX")),
                      ],
                      onChanged: (val) {
                        if (val == null) return;
                        setState(() {
                          paymentMethod = val;
                          cashPaid = null;
                          installments = 0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Método de pagamento",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dinheiro à vista
                    if (paymentMethod == "CASH") ...[
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: "Valor pago em dinheiro",
                          prefixText: "R\$ ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            cashPaid = double.tryParse(
                              val.replaceAll(',', '.'),
                            );
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Parcelas
                    if (paymentMethod == "PARCEL" ||
                        paymentMethod == "CASH") ...[
                      TextFormField(
                        initialValue: installments.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Parcelas (se houver)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            installments = int.tryParse(val) ?? 0;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Ações
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text("Cancelar"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: _isApproving
                                ? null
                                : () async {
                                    setState(() => _isApproving = true);
                                    try {
                                      final pos = await _getCurrentLocation();

                                      await InspectorService().approvePreSale(
                                        preSaleId: widget.preSale.id!,
                                        inspectorId: widget.inspectorId,
                                        paymentMethod: paymentMethod,
                                        installments: installments,
                                        cashPaid: cashPaid,
                                        latitude: pos.latitude,
                                        longitude: pos.longitude,
                                      );

                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Pré-venda aprovada ✅"),
                                        ),
                                      );

                                      Navigator.pop(context, true);
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Erro ao aprovar: $e"),
                                        ),
                                      );
                                    } finally {
                                      setState(() => _isApproving = false);
                                    }
                                  },
                            child: _isApproving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Aprovar"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
