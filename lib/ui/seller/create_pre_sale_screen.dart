import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/pre_sale_item.dart';
import '../../model/pre_sale.dart';
import '../../model/client.dart';
import '../../model/address.dart';
import '../../model/charging.dart';
import '../../services/pre_sale_service.dart';
import '../../services/seller_service.dart';
import '../../model/dto/seller_dto.dart';

class CreatePreSaleScreen extends StatefulWidget {
  final User user;
  final Charging charging;
  const CreatePreSaleScreen({
    super.key,
    required this.user,
    required this.charging,
  });

  @override
  State<CreatePreSaleScreen> createState() => _CreatePreSaleScreenState();
}

class _CreatePreSaleScreenState extends State<CreatePreSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final PreSaleService _preSaleService = PreSaleService();
  final SellerService _sellerService = SellerService();
  bool _isLoading = false;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _cpfCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();

  final Map<int, int> _selectedProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Finalizar Pré-venda")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Seleção de Produtos",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...widget.charging.chargingItems.map((item) {
                      final quantity = _selectedProducts[item.productId] ?? 0;
                      return ListTile(
                        title: Text(
                          "${item.nameProduct} (disp: ${item.quantity})",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    _selectedProducts[item.productId] =
                                        quantity - 1;
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
                                    _selectedProducts[item.productId] =
                                        quantity + 1;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    const Text(
                      "Dados do Cliente",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: "Nome"),
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
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Confirmar Pré-venda"),
                      onPressed: _sendPreSale,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _sendPreSale() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione ao menos 1 produto")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Cria a lista de produtos
      final items = widget.charging.chargingItems
          .where(
            (item) =>
                _selectedProducts[item.productId] != null &&
                _selectedProducts[item.productId]! > 0,
          )
          .map(
            (item) => PreSaleItem(
              productId: item.productId,
              productName: item.nameProduct, // agora vem o nome
              quantity: _selectedProducts[item.productId]!,
            ),
          )
          .toList();

      // Cria o cliente
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

      final seller = await _sellerService.getSellerByUserId(widget.user.id);

      final preSale = PreSale(
        preSaleDate: DateTime.now(),
        seller: seller, // <-- só envia o id aqui
        client: client,
        items: items,
        chargingId: widget.charging.id!,
      );

      // Envia para o backend
      await _preSaleService.createPreSale(preSale);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pré-venda criada com sucesso!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
