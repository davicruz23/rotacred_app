import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../model/dto/sale_collector_dto.dart';
import '../../services/collector_service.dart';
import '../../model/user.dart';
import '../login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
                "Venda: ${sale.saleDate.toLocal().toString().split(' ')[0]}",
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
        _buildInfoRow(Icons.phone, "Telefone", sale.client.phone),
        _buildInfoRow(
          Icons.location_on,
          "Endereço",
          "${sale.client.address.street}, nº ${sale.client.address.number}",
        ),
        _buildInfoRow(
          Icons.location_city,
          "Cidade",
          "${sale.client.address.city} - ${sale.client.address.zipCode}",
        ),
        if (sale.client.address.complement.isNotEmpty)
          _buildInfoRow(
            Icons.note,
            "Complemento",
            sale.client.address.complement,
          ),
        const SizedBox(height: 8),
        _buildLocationSection(sale),
      ],
    );
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
                    "Vencimento: ${inst.dueDate.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: inst.paid ? Colors.green : Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    "Valor: R\$ ${inst.amount.toStringAsFixed(2)}",
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
      final String googleMapsDirections =
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng";

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
        widget.user.id,
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
      final pos = await _getCurrentLocation();

      // Diálogo estilizado para seleção de pagamento
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

      if (paymentMethod == null) return;

      if (paymentMethod == "PIX") {
        final qrImage = await CollectorService().getPixQrCode(installmentId);

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
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.memory(qrImage, width: 200, height: 200),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Escaneie o QR Code para pagar\nApós confirmação, toque em 'Confirmar'",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                          child: const Text("Cancelar"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check_circle),
                          label: const Text("Confirmar"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          note: "Pago via PIX",
          latitude: pos.latitude,
          longitude: pos.longitude,
        );

        if (confirmed == true) {
          await CollectorService().collectInstallment(
            collectorId: _collectorId!,
            installmentId: installmentId,
            amount: amount,
            paymentMethod: paymentMethod,
            latitude: pos.latitude,
            longitude: pos.longitude,
            note: "PIX confirmado manualmente",
          );
        }
      } else {
        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          amount: amount,
          paymentMethod: paymentMethod,
          latitude: pos.latitude,
          longitude: pos.longitude,
          note: "Pagamento realizado com sucesso",
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pagamento registrado com sucesso! ✅"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      await _fetchCollectorSales();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao registrar pagamento: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
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

  // Future<void> _logout() async {
  //   final shouldLogout = await showDialog<bool>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       title: Row(
  //         children: const [
  //           Icon(Icons.logout_rounded, color: Colors.redAccent),
  //           SizedBox(width: 8),
  //           Text(
  //             'Sair da conta',
  //             style: TextStyle(
  //               color: Colors.black87,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ],
  //       ),
  //       content: const Text(
  //         'Deseja realmente sair da conta?',
  //         style: TextStyle(color: Colors.black54, fontSize: 15),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.redAccent,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //             ),
  //           ),
  //           onPressed: () => Navigator.pop(context, true),
  //           child: const Text('Sair'),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (shouldLogout == true && mounted) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const LoginScreen()),
  //     );
  //   }
  // }
}
