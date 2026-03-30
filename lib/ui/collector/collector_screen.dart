import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../model/dto/sale_collector_dto.dart';
import '../../services/collector_service.dart';
import '../../model/user.dart';
import '../login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CollectorScreen extends StatefulWidget {
  final User user;
  const CollectorScreen({super.key, required this.user});

  @override
  State<CollectorScreen> createState() => _CollectorScreenState();
}

class _CollectorScreenState extends State<CollectorScreen> {
  bool _isLoading = true;
  int? _collectorId;
  Map<String, List<SaleCollectorDTO>> _salesByCity = {};
  bool _rotating = false;
  bool _refreshing = false;
  final Map<int, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    _fetchCollectorSales();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: const [
              Icon(Icons.logout_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                'Sair da conta',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: const Text(
            'Deseja realmente sair da conta?',
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Sair'),
            ),
          ],
        ),
      );

      if (shouldLogout == true && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        title: Row(
          children: [
            //const Icon(Icons.attach_money_rounded, color: Colors.white),
            const SizedBox(width: 10),
            const Text(
              'Cobrador',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.white70),
                const SizedBox(width: 8),
                Text(
                  widget.user.name,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(width: 12),

                GestureDetector(
                  onTapDown: (_) => setState(() => _refreshing = true),
                  onTapUp: (_) {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      setState(() => _refreshing = false);
                      _fetchCollectorSales();
                    });
                  },
                  child: AnimatedRotation(
                    turns: _refreshing ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                GestureDetector(
                  onTapDown: (_) => setState(() => _rotating = true),
                  onTapUp: (_) {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      setState(() => _rotating = false);
                      _logout();
                    });
                  },
                  child: AnimatedRotation(
                    turns: _rotating ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Carregando vendas...",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
          : _salesByCity.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Nenhuma venda encontrada",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          //remover o reload aqui!
          : RefreshIndicator(
              onRefresh: _fetchCollectorSales,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: _salesByCity.entries.map((entry) {
                  final city = entry.key;
                  final sales = entry.value;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        city,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      children: sales
                          .map((sale) => _buildSaleCard(sale))
                          .toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildSaleCard(SaleCollectorDTO sale) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      shadowColor: Colors.blue.withOpacity(0.2),
      margin: const EdgeInsets.only(bottom: 20, left: 4, right: 4),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              sale.client.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          title: Text(
            sale.client.name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                "Data da Venda: ${DateFormat('dd/MM/yyyy').format(sale.saleDate.toLocal())}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          trailing: _buildStatusBadge(sale),
          children: [
            const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 4),
            _buildClientInfo(sale),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: _buildInstallments(sale),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(SaleCollectorDTO sale) {
    final paidCount = sale.installments.where((inst) => inst.paid).length;
    final totalCount = sale.installments.length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: paidCount == totalCount
            ? Colors.green.shade100
            : const Color.fromARGB(255, 240, 237, 235),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: paidCount == totalCount
              ? Colors.green
              : const Color.fromARGB(255, 97, 95, 93),
        ),
      ),
      child: Text(
        "$paidCount/$totalCount",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: paidCount == totalCount
              ? Colors.green
              : const Color.fromARGB(255, 97, 95, 93),
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildClientInfo(SaleCollectorDTO sale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informações do Cliente",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow(Icons.person, "CPF", sale.client.cpf),
        _buildInfoRow(Icons.phone, "TELEFONE", sale.client.phone),
        _buildInfoRow(
          Icons.location_on,
          "ENDEREÇO:",
          "${sale.client.address.street}, Nº: ${sale.client.address.number}, CEP: ${sale.client.address.zipCode}",
        ),
        _buildInfoRow(Icons.location_city, "CIDADE", sale.client.address.city),
        if (sale.client.address.complement.isNotEmpty)
          _buildInfoRow(
            Icons.note,
            "COMPLEMENTO",
            sale.client.address.complement,
          ),
        const SizedBox(height: 8),
        _buildLocationSection(sale),

        const SizedBox(height: 12),

        _buildReportProblemButton(sale),
      ],
    );
  }

  Widget _buildReportProblemButton(SaleCollectorDTO sale) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [Colors.red.shade400, Colors.red.shade600],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 87, 85, 84).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.warning_amber_rounded, size: 20),
          label: const Text(
            "Reportar Problema",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () => _showProblemDialog(sale),
        ),
      ),
    );
  }

  void _showProblemDialog(SaleCollectorDTO sale) {
    final descController = TextEditingController();
    int? selectedStatus;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔥 Título + ícone
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Reportar Problema",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🔘 opções (cards clicáveis)
                  _buildOptionCard(
                    title: "Acionar garantia",
                    subtitle: "Produto com defeito",
                    icon: Icons.verified_user_outlined,
                    selected: selectedStatus == 2,
                    onTap: () => setState(() => selectedStatus = 2),
                  ),

                  _buildOptionCard(
                    title: "Devolver produto",
                    subtitle: "Devolução",
                    icon: Icons.undo_outlined,
                    selected: selectedStatus == 4,
                    onTap: () => setState(() => selectedStatus = 4),
                  ),

                  _buildOptionCard(
                    title: "Produto recuperado",
                    subtitle: "Recuperado pelo Cobrador",
                    icon: Icons.check_circle_outline,
                    selected: selectedStatus == 5,
                    onTap: () => setState(() => selectedStatus = 5),
                  ),

                  const SizedBox(height: 16),

                  // // ✍️ descrição
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFFF7F8FA),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: TextField(
                  //     controller: descController,
                  //     maxLines: 3,
                  //     decoration: const InputDecoration(
                  //       hintText: "Descreva o problema (opcional)",
                  //       border: InputBorder.none,
                  //       contentPadding: EdgeInsets.all(12),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  // 🚀 botão
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (selectedStatus == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Selecione uma opção"),
                            ),
                          );
                          return;
                        }

                        Navigator.pop(context);

                        _showReturnItemsDialog(
                          sale,
                          selectedStatus!,
                          descController.text,
                        );
                      },
                      child: const Text("Continuar"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.blueAccent : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.blueAccent : Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemOption(
    String title,
    int status,
    SaleCollectorDTO sale,
    TextEditingController descController,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pop(context);
          _showReturnItemsDialog(sale, status, descController.text);
        },
      ),
    );
  }

  void _showReturnItemsDialog(
    SaleCollectorDTO sale,
    int status,
    String description,
  ) {
    final List<Map<String, dynamic>> selectedItems = [
      {"productId": null, "quantity": 1},
    ];

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔷 Título
                  const Text(
                    "Selecionar produtos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Lista de itens
                  ...selectedItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    final productId = item["productId"] as int?;
                    final quantity = item["quantity"] as int;

                    final product = sale.products.firstWhere(
                      (p) => p.id == productId,
                      orElse: () => sale.products.first,
                    );

                    final maxQty = productId == null ? 1 : product.quantity;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FA), // 🔥 fundo suave
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          // 🔽 Dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButton<int>(
                              value: productId,
                              hint: const Text("Selecione o produto"),
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: sale.products.map((p) {
                                return DropdownMenuItem(
                                  value: p.id,
                                  child: Text(
                                    p.nameProduct,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedItems[index]["productId"] = value;
                                  selectedItems[index]["quantity"] = 1;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          // 🔢 Quantidade + remover
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔢 Controle quantidade
                              Row(
                                children: [
                                  _buildQtyButton(
                                    icon: Icons.remove,
                                    enabled: quantity > 1,
                                    onTap: () {
                                      setState(() {
                                        selectedItems[index]["quantity"] =
                                            quantity - 1;
                                      });
                                    },
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  _buildQtyButton(
                                    icon: Icons.add,
                                    enabled:
                                        productId != null && quantity < maxQty,
                                    onTap: () {
                                      setState(() {
                                        selectedItems[index]["quantity"] =
                                            quantity + 1;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              // ❌ remover item
                              if (selectedItems.length > 1)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedItems.removeAt(index);
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  // ➕ adicionar item
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedItems.add({"productId": null, "quantity": 1});
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Adicionar item"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🚀 botão enviar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        final validItems = selectedItems
                            .where((e) => e["productId"] != null)
                            .toList();

                        if (validItems.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Selecione pelo menos um produto"),
                            ),
                          );
                          return;
                        }

                        final hasInvalidQty = validItems.any(
                          (e) => (e["quantity"] as int) <= 0,
                        );

                        if (hasInvalidQty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Quantidade inválida"),
                            ),
                          );
                          return;
                        }

                        final items = validItems
                            .map(
                              (e) => {
                                "productId": e["productId"],
                                "quantityReturned": e["quantity"],
                              },
                            )
                            .toList();

                        Navigator.pop(context);

                        _sendProblem(sale, status, description, items);
                      },
                      child: const Text(
                        "Enviar",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: enabled ? Colors.blue.shade50 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Colors.blueAccent : Colors.grey,
        ),
      ),
    );
  }

  Future<void> _sendProblem(
    SaleCollectorDTO sale,
    int status,
    String description,
    List<Map<String, dynamic>> items,
  ) async {
    try {
      await CollectorService().reportProblem(
        saleId: sale.id,
        items: items,
        status: status,
        description: description.isEmpty ? null : description,
      );

      await _fetchCollectorSales();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enviado com sucesso ✅")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label:",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(SaleCollectorDTO sale) {
    return Row(
      children: [
        const Icon(Icons.map, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Localização: ${sale.latitude != null && sale.longitude != null ? "Disponível" : "Não disponível"}",
            style: const TextStyle(fontSize: 14),
          ),
        ),
        if (sale.latitude != null && sale.longitude != null)
          ElevatedButton.icon(
            icon: const Icon(Icons.directions, size: 16),
            label: const Text("Mapa"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            onPressed: () =>
                _openMaps(sale.latitude!, sale.longitude!, context),
          ),
      ],
    );
  }

  Widget _buildInstallments(SaleCollectorDTO sale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Parcelas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        ...sale.installments.asMap().entries.map((entry) {
          final index = entry.key;
          final inst = entry.value; // ← Este é o objeto real da parcela
          final canPay =
              index == 0 ||
              sale.installments.sublist(0, index).every((prev) => prev.paid);

          return _buildInstallmentCard(inst, canPay, sale);
        }),
      ],
    );
  }

  Widget _buildInstallmentCard(
    dynamic inst, // Mudei para dynamic ou use o tipo correto
    bool canPay,
    SaleCollectorDTO sale,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: inst.paid ? Colors.green.shade50 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              inst.paid ? Icons.check_circle : Icons.pending_actions,
              color: inst.paid ? Colors.green : (Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vencimento: ${DateFormat('dd/MM/yyyy', 'pt_BR').format(inst.dueDate.toLocal())}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: inst.paid ? Colors.green : Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    inst.paid
                        ? "Pagamento recebido: R\$ ${inst.amount.toStringAsFixed(2)}"
                        : "Valor da parcela: R\$ ${inst.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: inst.paid ? Colors.green : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (!inst.paid) _buildActionButtons(inst, canPay, sale),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    dynamic inst, // Mudei para dynamic ou use o tipo correto
    bool canPay,
    SaleCollectorDTO sale,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botão de tentativa
        IconButton(
          icon: const Icon(
            Icons.report_problem,
            color: Color.fromARGB(255, 248, 23, 23),
          ),
          tooltip: "Registrar tentativa",
          onPressed: () => _showAttemptDialog(inst.id),
        ),

        // Botão de pagamento
        IconButton(
          icon: Icon(
            Icons.attach_money,
            color: canPay ? Colors.green : Colors.grey.shade400,
          ),
          tooltip: canPay
              ? "Marcar como pago"
              : "Pague as parcelas anteriores primeiro",
          onPressed: canPay ? () => _markAsPaid(inst.id, inst.amount) : null,
        ),
      ],
    );
  }

  void _showAttemptDialog(int installmentId) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.report_problem, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                "Registrar Tentativa",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              _buildAttemptOption(
                "CLIENTE AUSENTE",
                "Cliente não estava em casa",
              ),
              _buildAttemptOption("RECUSOU PAGAMENTO", "Cliente recusou pagar"),
              _buildAttemptOption("ENDEREÇO ERRADO", "Endereço incorreto"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttemptOption(String value, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.orange),
        title: Text(title),
        onTap: () {
          Navigator.pop(context);
          _registerAttempt(_collectorId!, value);
        },
      ),
    );
  }

  Future<void> _openMaps(double lat, double lng, BuildContext context) async {
    try {
      final String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      } else if (await canLaunchUrl(Uri.parse("geo:$lat,$lng?q=$lat,$lng"))) {
        await launchUrl(
          Uri.parse("geo:$lat,$lng?q=$lat,$lng"),
          mode: LaunchMode.externalApplication,
        );
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final String appleMapsUrl = "https://maps.apple.com/?ll=$lat,$lng";
        if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
          await launchUrl(
            Uri.parse(appleMapsUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          _showNoMapsAppDialog(context);
        }
      } else {
        _showNoMapsAppDialog(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao abrir Maps: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showNoMapsAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Apps de Mapas Não Encontrados"),
        content: const Text(
          "Nenhum app de mapas foi encontrado no seu dispositivo.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchCollectorSales() async {
    setState(() => _isLoading = true);
    try {
      final collector = await CollectorService().getCollectorByUserId(
        widget.user.serverId,
      );
      final salesByCity = await CollectorService().getSalesForCollector(
        collector.idCollector,
      );

      setState(() {
        _collectorId = collector.idCollector;
        _salesByCity = salesByCity;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao buscar vendas: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desativado');
    }

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

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _markAsPaid(int installmentId, double amount) async {
    try {
      print("🟡 INICIO _markAsPaid");
      print("➡ installmentId: $installmentId");
      print("➡ amount: $amount");
      print("➡ _collectorId: $_collectorId");

      print("🟡 Pegando localização...");
      final pos = await _getCurrentLocation();
      print("➡ latitude: ${pos.latitude}");
      print("➡ longitude: ${pos.longitude}");

      print("🟡 Abrindo dialog de pagamento...");
      final paymentMethod = await showDialog<String>(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.payment, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  "Forma de Pagamento",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPaymentOption(
                  icon: Icons.money,
                  title: "Dinheiro",
                  subtitle: "Pagamento em espécie",
                  value: "CASH",
                ),
                _buildPaymentOption(
                  icon: Icons.qr_code,
                  title: "PIX",
                  subtitle: "Pagamento instantâneo",
                  value: "PIX",
                ),
                _buildPaymentOption(
                  icon: Icons.credit_card,
                  title: "Cartão",
                  subtitle: "Débito ou Crédito",
                  value: "CREDIT",
                ),
              ],
            ),
          ),
        ),
      );

      print("➡ paymentMethod: $paymentMethod");

      if (paymentMethod == null) {
        print("⚠️ Usuário cancelou o dialog");
        return;
      }

      if (paymentMethod == "PIX") {
        print("🟢 FLOW PIX");

        print("🟡 Gerando QR Code...");
        final qrImage = await CollectorService().getPixQrCode(installmentId);
        print("✅ QR Code gerado");

        print("🟡 Abrindo dialog de confirmação PIX...");
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    size: 48,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Pagamento via PIX",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.memory(qrImage, width: 200, height: 200),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancelar"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Confirmar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        print("➡ PIX confirmado: $confirmed");

        print("🟡 Chamando collectInstallment (PIX sem amount)");
        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          note: "Pago via PIX",
          latitude: pos.latitude,
          longitude: pos.longitude,
        );
        print("✅ collectInstallment 1 OK");

        if (confirmed == true) {
          print("🟡 Chamando collectInstallment (PIX confirmado)");
          await CollectorService().collectInstallment(
            collectorId: _collectorId!,
            installmentId: installmentId,
            amount: amount,
            paymentMethod: paymentMethod,
            latitude: pos.latitude,
            longitude: pos.longitude,
            note: "PIX confirmado manualmente",
          );
          print("✅ collectInstallment 2 OK");
        }
      } else if (paymentMethod == "CASH") {
        print("🟢 FLOW CASH");
        print("➡ collectorId: $_collectorId");

        print("🟡 Perguntando valor em dinheiro...");
        final cashAmount = await _askCashAmount(amount);
        print("➡ cashAmount: $cashAmount");

        if (cashAmount == null) {
          print("⚠️ Usuário cancelou valor");
          return;
        }

        print("🟡 Chamando paySale...");
        await CollectorService().paySale(
          installmentId: installmentId,
          amount: cashAmount,
        );
        print("✅ paySale OK");

        print("🟡 Chamando collectInstallment (CASH)");
        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          amount: cashAmount,
          paymentMethod: paymentMethod,
          latitude: pos.latitude,
          longitude: pos.longitude,
          note: "Pago em dinheiro",
          requiresPaySale: true,
        );
        print("✅ collectInstallment CASH OK");
      } else {
        print("🟢 FLOW OUTROS ($paymentMethod)");

        print("🟡 Chamando collectInstallment (OUTROS)");
        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          amount: amount,
          paymentMethod: paymentMethod,
          latitude: pos.latitude,
          longitude: pos.longitude,
          note: "Pagamento realizado com sucesso",
        );
        print("✅ collectInstallment OUTROS OK");
      }

      print("🟡 Mostrando sucesso");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pagamento registrado com sucesso! ✅"),
          backgroundColor: Colors.green,
        ),
      );

      print("🟡 Atualizando lista...");
      await _fetchCollectorSales();
      print("✅ Finalizou tudo");
    } catch (e) {
      print("💥 ERRO NO _markAsPaid: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao registrar pagamento: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<double?> _askCashAmount(double maxValue) async {
    final TextEditingController controller = TextEditingController();
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    String? errorText;

    return await showDialog<double>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            double? value;

            try {
              value = currencyFormat.parse(controller.text) as double;
            } catch (_) {
              value = null;
            }

            bool isValid = value != null && value > 0 && value <= maxValue;

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.attach_money, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Receber pagamento",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Valor máximo",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            currencyFormat.format(maxValue),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "R\$ 0,00",
                        errorText: errorText,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (text) {
                        // 🔥 aplica máscara
                        String digits = text.replaceAll(RegExp(r'[^0-9]'), '');

                        double number =
                            double.parse(digits.isEmpty ? '0' : digits) / 100;

                        String newText = currencyFormat.format(number);

                        controller.value = TextEditingValue(
                          text: newText,
                          selection: TextSelection.collapsed(
                            offset: newText.length,
                          ),
                        );

                        setState(() {
                          final v = number;

                          if (v <= 0) {
                            errorText = "Informe um valor válido";
                          } else if (v > maxValue) {
                            errorText = "Maior que o permitido";
                          } else {
                            errorText = null;
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Cancelar"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isValid
                                ? () => Navigator.pop(context, value)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Confirmar"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pop(context, value),
      ),
    );
  }

  Future<void> _registerAttempt(int installmentId, String status) async {
    try {
      final pos = await _getCurrentLocation();

      await CollectorService().collectInstallment(
        collectorId: _collectorId!,
        installmentId: installmentId,
        note: status,
        latitude: pos.latitude,
        longitude: pos.longitude,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tentativa registrada: $status ✅"),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao registrar tentativa: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
