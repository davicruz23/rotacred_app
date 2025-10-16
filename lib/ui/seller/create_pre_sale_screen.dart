import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/pre_sale_item.dart';
import '../../model/pre_sale.dart';
import '../../model/client.dart';
import '../../model/address.dart';
import '../../model/charging.dart';
import '../../services/pre_sale_service.dart';
import '../../services/seller_service.dart';

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
  final TextEditingController _numberCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _zipCodeCtrl = TextEditingController();
  final TextEditingController _complementCtrl = TextEditingController();

  final Map<int, int> _selectedProducts = {};

  final List<String> cidadesParaiba = [
  'VÁRZEA','AREIA','ALAGOINHA','ALAGOA GRANDE','GALANTE',
  'PEDREGAL','LAGOA SECA','SOLEDADE','CUBATI','SÃO VICENTE DO SERIDÓ',
  'PEDRA LAVRADA','LAGOA DE ROÇA','ALAGOA NOVA','SOLÂNEA','INGÁ',
  'SALGADO DE SÃO FÉLIX','QUEIMADAS','AROEIRAS','PILAR','ITATUBA',
  'BOQUEIRÃO','GUARABIRA','PILÕEZINHOS','ITAPOROROCA','BELÉM',
  'PIRPIRITUBA','ITABAIANA','CRUZ DO ESPÍRITO SANTO','JUAREZ TÁVORA',
  'POCINHOS','ESPERANÇA','MONTEIRO','SUMÉ','BOA VISTA','CAMPINA GRANDE',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Pré-venda"),
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      "Seleção de Produtos",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.charging.chargingItems.map((item) {
                      final quantity = _selectedProducts[item.productId] ?? 0;
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nameProduct,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "R\$ ${item.priceProduct} • Disponível: ${item.quantity}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 0) {
                                          _selectedProducts[item.productId] =
                                              quantity - 1;
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
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
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    const Text(
                      "Dados do Cliente",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      shadowColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dados do Cliente",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(thickness: 1.2),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Nome",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _cpfCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "CPF",
                                      prefixIcon: Icon(Icons.badge),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Telefone e CEP
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Telefone",
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _zipCodeCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "CEP",
                                      prefixIcon: Icon(Icons.location_on),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _streetCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Rua",
                                      prefixIcon: Icon(Icons.home),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _numberCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Número",
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                          if (textEditingValue.text.isEmpty) {
                                            return cidadesParaiba;
                                          }
                                          return cidadesParaiba.where(
                                            (cidade) =>
                                                cidade.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase(),
                                                ),
                                          );
                                        },
                                    onSelected: (String selection) {
                                      _cityCtrl.text = selection;
                                    },
                                    fieldViewBuilder:
                                        (
                                          context,
                                          controller,
                                          focusNode,
                                          onEditingComplete,
                                        ) {
                                          controller.text = _cityCtrl.text;
                                          controller.selection =
                                              TextSelection.fromPosition(
                                                TextPosition(
                                                  offset:
                                                      controller.text.length,
                                                ),
                                              );
                                          return TextFormField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            onEditingComplete:
                                                onEditingComplete,
                                            decoration: const InputDecoration(
                                              labelText: "Cidade",
                                            ),
                                          );
                                        },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _stateCtrl.text.isNotEmpty
                                        ? _stateCtrl.text
                                        : 'PB',
                                    decoration: const InputDecoration(
                                      labelText: "Estado",
                                    ),
                                    items: [
                                      'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES',
                                      'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR',
                                      'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC',
                                      'SP', 'SE', 'TO',
                                    ].map((estado) {
                                          return DropdownMenuItem(
                                            value: estado,
                                            child: Text(estado),
                                          );
                                        }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _stateCtrl.text =
                                              val;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _complementCtrl,
                              decoration: const InputDecoration(
                                labelText: "Complemento",
                                prefixIcon: Icon(Icons.note),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text(
                          "Confirmar Pré-venda",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: _sendPreSale,
                      ),
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
      final items = widget.charging.chargingItems
          .where(
            (item) =>
                _selectedProducts[item.productId] != null &&
                _selectedProducts[item.productId]! > 0,
          )
          .map(
            (item) => PreSaleItem(
              productId: item.productId,
              productName: item.nameProduct,
              quantity: _selectedProducts[item.productId]!,
            ),
          )
          .toList();

      final client = Client(
        id: 0,
        name: _nameCtrl.text,
        cpf: _cpfCtrl.text,
        phone: _phoneCtrl.text,
        address: Address(
          id: 0,
          state: _stateCtrl.text,
          city: _cityCtrl.text,
          street: _streetCtrl.text,
          number: _numberCtrl.text,
          zipCode: _zipCodeCtrl.text,
          complement: _complementCtrl.text,
        ),
      );

      final seller = await _sellerService.getSellerByUserId(widget.user.id);

      final preSale = PreSale(
        preSaleDate: DateTime.now(),
        seller: seller,
        client: client,
        items: items,
        chargingId: widget.charging.id!,
      );

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
