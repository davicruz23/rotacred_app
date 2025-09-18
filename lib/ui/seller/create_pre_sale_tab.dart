import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/pre_sale.dart';
import '../../model/pre_sale_item.dart';
import '../../model/client.dart';
import '../../model/address.dart';
import '../../services/pre_sale_service.dart';
import '../../services/charging_service.dart';
import '../../model/charging.dart';

class CreatePreSaleTab extends StatefulWidget {
  final User user;
  const CreatePreSaleTab({super.key, required this.user});

  @override
  State<CreatePreSaleTab> createState() => _CreatePreSaleTabState();
}

class _CreatePreSaleTabState extends State<CreatePreSaleTab> {
  final _formKey = GlobalKey<FormState>();
  final PreSaleService _preSaleService = PreSaleService();
  final ChargingService _chargingService = ChargingService();
  bool _isLoading = false;

  List<Charging> _chargings = [];
  Charging? _selectedCharging;

  // Cliente
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _cpfCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();

  // Produtos selecionados (productId -> quantidade escolhida)
  final Map<int, int> _selectedProducts = {};

  @override
  void initState() {
    super.initState();
    _loadChargings();
  }

  Future<void> _loadChargings() async {
    setState(() => _isLoading = true);
    try {
      final list = await _chargingService.getChargings();
      setState(() {
        _chargings = list;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar carregamentos: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text("Dados do Cliente",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Nome"),
              validator: (v) => v!.isEmpty ? "Informe o nome" : null,
            ),
            TextFormField(
              controller: _cpfCtrl,
              decoration: const InputDecoration(labelText: "CPF"),
            ),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: "Telefone"),
            ),
            TextFormField(
              controller: _cityCtrl,
              decoration: const InputDecoration(labelText: "Cidade"),
            ),
            TextFormField(
              controller: _streetCtrl,
              decoration: const InputDecoration(labelText: "Rua"),
            ),
            const SizedBox(height: 20),

            const Text("Selecione o Carregamento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<Charging>(
              value: _selectedCharging,
              items: _chargings.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text("${c.description} - ${c.chargingDate}"),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCharging = val;
                  _selectedProducts.clear();
                });
              },
              validator: (val) =>
                  val == null ? "Selecione um carregamento" : null,
            ),

            const SizedBox(height: 20),

            if (_selectedCharging != null) ...[
              const Text("Seleção de Produtos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._selectedCharging!.chargingItems.map((item) {
                final quantity = _selectedProducts[item.productId] ?? 0;
                return ListTile(
                  title: Text("Produto ${item.productId} (disp: ${item.quantity})"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) {
                              _selectedProducts[item.productId] = quantity - 1;
                            }
                          });
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (quantity < item.quantity) {
                            setState(() {
                              _selectedProducts[item.productId] = quantity + 1;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],

            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text("Finalizar Pré-venda"),
              onPressed: _sendPreSale,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendPreSale() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCharging == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione um carregamento")),
      );
      return;
    }
    if (_selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione pelo menos 1 produto")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final items = _selectedProducts.entries
          .map((e) => PreSaleItem(productId: e.key, quantity: e.value))
          .toList();

      final client = Client(
        id: 0,
        name: _nameCtrl.text,
        cpf: _cpfCtrl.text,
        phone: _phoneCtrl.text,
        address: Address(
          id: 0,
          state: "RN",
          city: _cityCtrl.text,
          street: _streetCtrl.text,
          number: "0",
          zipCode: "00000-000",
          complement: "",
        ),
      );

      final preSale = PreSale(
        preSaleDate: DateTime.now(),
        sellerId: widget.user.id,
        client: client,
        products: items,
        chargingId: _selectedCharging!.id,
      );

      await _preSaleService.createPreSale(preSale);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pré-venda criada com sucesso!")),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedCharging = null;
        _selectedProducts.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
