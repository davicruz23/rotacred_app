import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotacred_app/services/cep_service.dart';
import '../../model/user.dart';
import '../../model/pre_sale_item.dart';
import '../../model/pre_sale.dart';
import '../../model/client.dart';
import '../../model/address.dart';
import '../../model/charging.dart';
import '../../services/pre_sale_service.dart';
import '../../services/seller_service.dart';
import '../../services/cpf_validator_service.dart';
import '../../services/client_service.dart';
import 'package:uuid/uuid.dart';

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
  final CepService _cepService = CepService();
  final SellerService _sellerService = SellerService();
  final CpfValidatorService _cpfValidatorService = CpfValidatorService();
  final ClientService _clientService = ClientService();

  bool _isLoading = false;
  bool _useExistingClient = true;
  bool _searchingClient = false;
  bool _validandoCpf = false;

  String _selectedState = 'PB';
  String? _cpfErro;

  Client? _selectedClient;
  List<Client> _clientResults = [];
  Timer? _clientSearchDebounce;

  final _clientSearchCtrl = TextEditingController();
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

  @override
  void dispose() {
    _clientSearchDebounce?.cancel();

    _clientSearchCtrl.dispose();
    _nameCtrl.dispose();
    _cpfCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    _streetCtrl.dispose();
    _numberCtrl.dispose();
    _stateCtrl.dispose();
    _zipCodeCtrl.dispose();
    _complementCtrl.dispose();

    super.dispose();
  }

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

  void _clearClientFields() {
    _selectedClient = null;
    _clientSearchCtrl.clear();
    _clientResults = [];

    _nameCtrl.clear();
    _cpfCtrl.clear();
    _phoneCtrl.clear();

    _cityCtrl.clear();
    _streetCtrl.clear();
    _numberCtrl.clear();
    _stateCtrl.clear();
    _zipCodeCtrl.clear();
    _complementCtrl.clear();

    _selectedState = 'PB';
    _cpfErro = null;
  }

  void _changeClientMode(bool useExistingClient) {
    setState(() {
      _useExistingClient = useExistingClient;
      _clearClientFields();
    });
  }

  void _onClientSearchChanged(String value) {
    _clientSearchDebounce?.cancel();

    if (_selectedClient != null) {
      setState(() {
        _selectedClient = null;
        _nameCtrl.clear();
        _cpfCtrl.clear();
        _phoneCtrl.clear();
      });
    }

    _clientSearchDebounce = Timer(const Duration(milliseconds: 400), () {
      _searchClients(value);
    });
  }

  Future<void> _searchClients(String value) async {
    final search = value.trim();

    if (search.length < 3) {
      if (!mounted) return;
      setState(() => _clientResults = []);
      return;
    }

    setState(() => _searchingClient = true);

    try {
      final result = await _clientService.searchClients(search);

      if (!mounted) return;

      setState(() {
        _clientResults = result;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _clientResults = [];
      });
    } finally {
      if (!mounted) return;

      setState(() => _searchingClient = false);
    }
  }

  void _selectExistingClient(Client client) {
    setState(() {
      _selectedClient = client;
      _clientSearchCtrl.text = '${client.name} - ${client.cpf}';

      _nameCtrl.text = client.name;
      _cpfCtrl.text = client.cpf;
      _phoneCtrl.text = client.phone;

      _clientResults = [];
      _cpfErro = null;
    });
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
                  child: RadioListTile<bool>(
                    title: const Text('Buscar cliente'),
                    value: true,
                    groupValue: _useExistingClient,
                    onChanged: (value) {
                      if (value == null) return;
                      _changeClientMode(value);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Cliente novo'),
                    value: false,
                    groupValue: _useExistingClient,
                    onChanged: (value) {
                      if (value == null) return;
                      _changeClientMode(value);
                    },
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 12),

            if (_useExistingClient) ...[
              _buildClientSearchField(),
              const SizedBox(height: 12),
            ],

            _buildBasicClientFields(),

            if (!_useExistingClient) ...[
              const SizedBox(height: 12),
              _buildAddressFields(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildClientSearchField() {
    return Column(
      children: [
        TextFormField(
          controller: _clientSearchCtrl,
          decoration: _inputDecoration("Buscar por nome ou CPF *", Icons.search)
              .copyWith(
                suffixIcon: _searchingClient
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
          onChanged: _onClientSearchChanged,
          validator: (_) {
            if (_useExistingClient && _selectedClient == null) {
              return 'Selecione um cliente';
            }
            return null;
          },
        ),

        if (_clientResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: _clientResults.map((client) {
                return ListTile(
                  title: Text(client.name),
                  subtitle: Text('CPF: ${client.cpf}'),
                  trailing: const Icon(Icons.check_circle_outline),
                  onTap: () => _selectExistingClient(client),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildBasicClientFields() {
    final bool enabled = !_useExistingClient;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _nameCtrl,
                enabled: enabled,
                decoration: _inputDecoration("Nome *", Icons.person),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _cpfCtrl,
                enabled: enabled,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: _inputDecoration(
                  "CPF *",
                  Icons.badge,
                ).copyWith(errorText: enabled ? _cpfErro : null),
                validator: (v) {
                  if (_useExistingClient) return null;

                  if (v == null || v.isEmpty) {
                    return 'Informe o CPF';
                  }

                  if (v.length < 11) {
                    return 'CPF deve ter 11 dígitos';
                  }

                  if (_cpfErro != null) {
                    return _cpfErro;
                  }

                  return null;
                },
                onChanged: enabled ? _onCpfChanged : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _phoneCtrl,
          enabled: enabled,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _inputDecoration("Telefone *", Icons.phone),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Informe o telefone';
            if (v.length < 10) return 'Telefone inválido';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        Row(
          children: [
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
                onChanged: (value) {
                  if (value.length == 8) {
                    _buscarCepEPreencher(value);
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedState,
                decoration: _inputDecoration("Estado *", Icons.map_outlined),
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
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue value) {
            if (value.text.isEmpty) return cidadesParaiba;

            return cidadesParaiba.where(
              (cidade) =>
                  cidade.toLowerCase().contains(value.text.toLowerCase()),
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
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a cidade' : null,
                  onChanged: (value) {
                    _cityCtrl.text = value;
                  },
                );
              },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _complementCtrl,
          decoration: _inputDecoration("Complemento", Icons.note_alt_outlined),
        ),
      ],
    );
  }

  Future<void> _onCpfChanged(String cpf) async {
    if (cpf.length < 11) {
      if (_cpfErro != null) {
        setState(() => _cpfErro = null);
      }
      return;
    }

    if (cpf.length == 11 && !_validandoCpf) {
      _validandoCpf = true;

      final resultado = await _cpfValidatorService.validarCpf(cpf);

      if (!mounted) return;

      setState(() {
        if (resultado == null) {
          _cpfErro = null;
        } else {
          _cpfErro = resultado ? null : 'CPF inválido';
        }
      });

      _validandoCpf = false;
    }
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
      final uuid = const Uuid().v4();

      final client = _useExistingClient
          ? _selectedClient!
          : Client(
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

      final seller = await _sellerService.getSellerByUserId(
        widget.user.serverId,
      );

      final preSale = PreSale(
        uuidPreSale: uuid,
        preSaleDate: DateTime.now(),
        seller: seller,
        client: client,
        items: widget.selectedItems,
        chargingId: widget.charging.serverId,
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
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _buscarCepEPreencher(String cep) async {
    final data = await _cepService.buscarPorCep(cep);

    if (data == null) {
      return;
    }

    debugPrint('CEP retornou: $data');

    setState(() {
      _streetCtrl.text = data['street'] ?? data['logradouro'] ?? '';
      _cityCtrl.text = data['city'] ?? data['localidade'] ?? '';

      final estadoRetornado = data['state'] ?? data['uf'] ?? '';
      if (estadoRetornado.isNotEmpty) {
        _selectedState = estadoRetornado.toUpperCase();
        _stateCtrl.text = _selectedState;
      }

      FocusScope.of(context).requestFocus(FocusNode());

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_numberCtrl.text.isEmpty) {
          FocusScope.of(context).requestFocus(FocusNode());

          Future.delayed(const Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(FocusNode());
          });
        }
      });
    });
  }
}
