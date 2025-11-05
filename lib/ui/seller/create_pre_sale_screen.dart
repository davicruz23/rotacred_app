import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<PreSaleItem> selectedItems;

  const CreatePreSaleScreen({
    super.key,
    required this.user,
    required this.charging,
    required this.selectedItems,
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

  final _nameCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _zipCodeCtrl = TextEditingController();
  final _complementCtrl = TextEditingController();

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

  double get _totalValue => widget.selectedItems.fold(
    0.0,
    (total, item) =>
        total + (item.quantity * (item.unitPrice as num).toDouble()),
  );

  InputDecoration _inputDecoration(String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Pré-venda"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildSelectedItemsCard(),
                    const SizedBox(height: 20),
                    const Text(
                      "Dados do Cliente",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildClientForm(),
                    const SizedBox(height: 20),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSelectedItemsCard() {
    return Card(
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.shopping_cart, color: Colors.green),
                SizedBox(width: 8),
                Text(
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
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Qtd: ${item.quantity}",
                            style: const TextStyle(color: Colors.grey),
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
            Divider(color: Colors.green.shade200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Valor Total:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildClientForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameCtrl,
                    decoration: _inputDecoration("Nome *", Icons.person),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Informe o nome' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _cpfCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDecoration("CPF *", Icons.badge),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe o CPF';
                      if (v.length != 11) return 'CPF inválido (11 dígitos)';
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
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDecoration("Telefone *", Icons.phone),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe o telefone';
                      if (v.length < 10) return 'Telefone inválido';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _zipCodeCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDecoration("CEP *", Icons.location_on),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe o CEP';
                      if (v.length != 8) return 'CEP inválido';
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
                    decoration: _inputDecoration("Rua *", Icons.home),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Informe a rua' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _numberCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Número *", null),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Informe o número' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue value) {
                      if (value.text.isEmpty) return cidadesParaiba;
                      return cidadesParaiba.where(
                        (cidade) => cidade.toLowerCase().contains(
                          value.text.toLowerCase(),
                        ),
                      );
                    },
                    onSelected: (String selection) {
                      setState(() => _cityCtrl.text = selection);
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                          controller.text = _cityCtrl.text;
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration: _inputDecoration(
                              "Cidade *",
                              Icons.location_city_rounded,
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? 'Informe a cidade'
                                : null,
                            onChanged: (value) {
                              _cityCtrl.text = value;
                            },
                          );
                        },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedState,
                    decoration: _inputDecoration(
                      "Estado *",
                      Icons.map_outlined,
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
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Selecione um estado' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _complementCtrl,
              decoration: _inputDecoration(
                "Complemento",
                Icons.note_alt_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.check_circle_outline),
        label: const Text(
          "Confirmar Pré-venda",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.green.shade600,
        ),
        onPressed: _sendPreSale,
      ),
    );
  }

  Future<void> _sendPreSale() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final client = Client(
        id: 0,
        name: _nameCtrl.text.trim(),
        cpf: _cpfCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        address: Address(
          id: 0,
          state: _selectedState,
          city: _cityCtrl.text.trim(),
          street: _streetCtrl.text.trim(),
          number: _numberCtrl.text.trim(),
          zipCode: _zipCodeCtrl.text.trim(),
          complement: _complementCtrl.text.trim(),
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
        const SnackBar(content: Text("✅ Pré-venda criada com sucesso!")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Erro ao criar pré-venda: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
