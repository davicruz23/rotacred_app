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

  Future<void> _markAsPaid(int installmentId, double amount) async {
    try {
      final pos = await _getCurrentLocation();

      // Exibir seleção da forma de pagamento
      final paymentMethod = await showDialog<String>(
        context: context,
        builder: (_) => SimpleDialog(
          title: const Text("Selecione a forma de pagamento"),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, "CASH"),
              child: const Text("💵 Dinheiro"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, "PIX"),
              child: const Text("⚡ Pix"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, "CREDIT"),
              child: const Text("💳 Cartão"),
            ),
          ],
        ),
      );

      if (paymentMethod == null) return;

      if (paymentMethod == "PIX") {
        // Gera e busca o QR Code do backend
        final qrImage = await CollectorService().getPixQrCode(installmentId);

        // Exibe o QR Code com opção de confirmar
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text("Pagamento via PIX"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(qrImage, width: 200, height: 200),
                const SizedBox(height: 10),
                const Text(
                  "Escaneie o QR Code acima para pagar.\n"
                  "Após o cliente confirmar o envio, toque em 'Confirmar pagamento'.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancelar"),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Confirmar pagamento"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        );

        // Registra tentativa
        await CollectorService().collectInstallment(
          collectorId: _collectorId!,
          installmentId: installmentId,
          note: "Pago via PIX",
          latitude: pos.latitude,
          longitude: pos.longitude,
        );

        // Se o cobrador confirmou manualmente, registra o pagamento
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
        // Pagamento direto (dinheiro/cartão)
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pagamento registrado ✅")));

      await _fetchCollectorSales();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao registrar pagamento: $e")),
      );
    }
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
        SnackBar(content: Text("Tentativa registrada: $status ✅")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao registrar tentativa: $e")),
      );
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Localização: ${sale.latitude != null && sale.longitude != null ? "${sale.latitude}, ${sale.longitude}" : "Não disponível"}",
                                ),
                              ),
                              if (sale.latitude != null &&
                                  sale.longitude != null)
                                IconButton(
                                  icon: const Icon(
                                    Icons.map,
                                    color: Colors.blue,
                                  ),
                                  tooltip: "Abrir no Maps",
                                  onPressed: () => _openMaps(
                                    sale.latitude!,
                                    sale.longitude!,
                                    context,
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 4),
                          ...sale.installments.asMap().entries.map((entry) {
                            final index = entry.key;
                            final inst = entry.value;

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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!inst.paid)
                                    IconButton(
                                      icon: const Icon(Icons.location_pin),
                                      tooltip: "Registrar tentativa",
                                      onPressed: () async {
                                        final result = await showDialog<String>(
                                          context: context,
                                          builder: (_) => SimpleDialog(
                                            title: const Text(
                                              "Registrar tentativa",
                                            ),
                                            children: [
                                              SimpleDialogOption(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  "CLIENTE AUSENTE",
                                                ),
                                                child: const Text(
                                                  "Cliente ausente",
                                                ),
                                              ),
                                              SimpleDialogOption(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  "RECUSOU PAGAMENTO",
                                                ),
                                                child: const Text(
                                                  "Recusou pagamento",
                                                ),
                                              ),
                                              SimpleDialogOption(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  "ENDEREÇO ERRADO",
                                                ),
                                                child: const Text(
                                                  "Endereço errado",
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (result != null) {
                                          await _registerAttempt(
                                            inst.id,
                                            result,
                                          );
                                        }
                                      },
                                    ),
                                  inst.paid
                                      ? const Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                        )
                                      : IconButton(
                                          icon: const Icon(
                                            Icons.attach_money,
                                            color: Color.fromARGB(
                                              255,
                                              235,
                                              2,
                                              2,
                                            ),
                                          ),
                                          tooltip: canPay
                                              ? "Marcar como pago"
                                              : "Pague as parcelas anteriores primeiro",
                                          onPressed: canPay
                                              ? () async {
                                                  await _markAsPaid(
                                                    inst.id,
                                                    inst.amount,
                                                  );
                                                }
                                              : null,
                                        ),
                                ],
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

  Future<void> _openMaps(double lat, double lng, BuildContext context) async {
    try {
      // URL do Google Maps
      final String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

      // URL alternativa para navegação
      final String googleMapsDirections =
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng";

      // Tentar abrir Google Maps
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      }
      // Tentar abrir com geo: scheme como fallback
      else if (await canLaunchUrl(Uri.parse("geo:$lat,$lng?q=$lat,$lng"))) {
        await launchUrl(
          Uri.parse("geo:$lat,$lng?q=$lat,$lng"),
          mode: LaunchMode.externalApplication,
        );
      }
      // Tentar abrir Apple Maps no iOS
      else if (Theme.of(context).platform == TargetPlatform.iOS) {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao abrir Maps: $e")));
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
}
