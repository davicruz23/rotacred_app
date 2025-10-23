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
  final List<PreSaleItem>
  selectedItems; // ✅ AGORA RECEBE OS PRODUTOS SELECIONADOS

  const CreatePreSaleScreen({
    super.key,
    required this.user,
    required this.charging,
    required this.selectedItems, // ✅ PARÂMETRO OBRIGATÓRIO
  });

  @override
  State<CreatePreSaleScreen> createState() => _CreatePreSaleScreenState();
}

class _CreatePreSaleScreenState extends State<CreatePreSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final PreSaleService _preSaleService = PreSaleService();
  final SellerService _sellerService = SellerService();
  bool _isLoading = false;

  String _selectedState = 'PB';

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _cpfCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _numberCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _zipCodeCtrl = TextEditingController();
  final TextEditingController _complementCtrl = TextEditingController();

  final List<String> cidadesParaiba = [
    'VÁRZEA',
    'AREIA',
    'ALAGOINHA',
    'ALAGOA GRANDE',
    'GALANTE',
    'PEDREGAL',
    'LAGOA SECA',
    'SOLEDADE',
    'CUBATI',
    'SÃO VICENTE DO SERIDÓ',
    'PEDRA LAVRADA',
    'LAGOA DE ROÇA',
    'ALAGOA NOVA',
    'SOLÂNEA',
    'INGÁ',
    'SALGADO DE SÃO FÉLIX',
    'QUEIMADAS',
    'AROEIRAS',
    'PILAR',
    'ITATUBA',
    'BOQUEIRÃO',
    'GUARABIRA',
    'PILÕEZINHOS',
    'ITAPOROROCA',
    'BELÉM',
    'PIRPIRITUBA',
    'ITABAIANA',
    'CRUZ DO ESPÍRITO SANTO',
    'JUAREZ TÁVORA',
    'POCINHOS',
    'ESPERANÇA',
    'MONTEIRO',
    'SUMÉ',
    'BOA VISTA',
    'CAMPINA GRANDE',
  ];

  double get _totalValue {
    return widget.selectedItems.fold(
      0.0,
      (total, item) =>
          total + (item.quantity * (item.unitPrice as num).toDouble()),
    );
  }

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
                    // SEÇÃO DE PRODUTOS SELECIONADOS
                    Card(
                      color: Colors.green.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Produtos Selecionados",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...widget.selectedItems.map(
                              (item) => Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green.shade100,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.productName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Quantidade: ${item.quantity}",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "R\$ ${(item.quantity * item.unitPrice).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Divider(color: Colors.green.shade200),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Valor Total:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "R\$ ${_totalValue.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

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
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Nome *",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o nome do cliente';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _cpfCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "CPF *",
                                      prefixIcon: Icon(Icons.badge),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o CPF do cliente';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Telefone *",
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o telefone do cliente';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _zipCodeCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "CEP *",
                                      prefixIcon: Icon(Icons.location_on),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o CEP';
                                      }
                                      return null;
                                    },
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
                                      labelText: "Rua *",
                                      prefixIcon: Icon(Icons.home),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a rua';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _numberCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Número *",
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o número';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Cidade e Estado
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
                                      setState(() {
                                        _cityCtrl.text = selection;
                                      });
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
                                              labelText: "Cidade *",
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Informe a cidade';
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedState,
                                    decoration: const InputDecoration(
                                      labelText: "Estado *",
                                    ),
                                    items:
                                        [
                                          'AC',
                                          'AL',
                                          'AP',
                                          'AM',
                                          'BA',
                                          'CE',
                                          'DF',
                                          'ES',
                                          'GO',
                                          'MA',
                                          'MT',
                                          'MS',
                                          'MG',
                                          'PA',
                                          'PB',
                                          'PR',
                                          'PE',
                                          'PI',
                                          'RJ',
                                          'RN',
                                          'RS',
                                          'RO',
                                          'RR',
                                          'SC',
                                          'SP',
                                          'SE',
                                          'TO',
                                        ].map((estado) {
                                          return DropdownMenuItem(
                                            value: estado,
                                            child: Text(estado),
                                          );
                                        }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedState = val;
                                          _stateCtrl.text = val;
                                        });
                                      }
                                    },
                                    validator: (v) => (v == null || v.isEmpty)
                                        ? 'Selecione um estado'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Complemento
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

                    const SizedBox(height: 20),

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

    setState(() => _isLoading = true);
    try {
      final client = Client(
        id: 0,
        name: _nameCtrl.text,
        cpf: _cpfCtrl.text,
        phone: _phoneCtrl.text,
        address: Address(
          id: 0,
          state: _selectedState,
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
        items: widget.selectedItems,
        chargingId: widget.charging.id!,
      );

      await _preSaleService.createPreSale(preSale);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pré-venda criada com sucesso!")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao criar pré-venda: $e")));
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
