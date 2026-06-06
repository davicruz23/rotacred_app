import 'dart:async';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../model/charging.dart';
import '../../model/pre_sale_item.dart';
import '../login_screen.dart';
import 'charging_products_screen.dart';
import '../../services/charging_service.dart';

class SellerScreen extends StatefulWidget {
  final User user;

  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  Charging? _currentCharging;
  bool _loading = true;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  // productId -> quantity
  final Map<int, int> _selectedProducts = {};

  // productId -> PreSaleItem completo
  final Map<int, PreSaleItem> _selectedProductDetails = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadCurrentCharging();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _loadCurrentCharging(search: _searchController.text.trim());
    });
  }

  Future<void> _loadCurrentCharging({String? search}) async {
    try {
      setState(() => _loading = true);

      final chargings = await ChargingService().getChargings(
        nameProduct: search,
        brand: search,
      );

      if (!mounted) return;

      setState(() {
        _currentCharging = chargings.isNotEmpty ? chargings.first : null;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar carregamento: $e')),
      );
    }
  }

  void _updateSelectedProduct({
    required int productId,
    required int quantity,
    required String productName,
    required double unitPrice,
  }) {
    setState(() {
      if (quantity <= 0) {
        _selectedProducts.remove(productId);
        _selectedProductDetails.remove(productId);
      } else {
        _selectedProducts[productId] = quantity;
        _selectedProductDetails[productId] = PreSaleItem(
          productId: productId,
          productName: productName,
          quantity: quantity,
          unitPrice: unitPrice,
        );
      }
    });
  }

  void _clearAllSelectedProducts() {
    setState(() {
      _selectedProducts.clear();
      _selectedProductDetails.clear();
    });
  }

  List<PreSaleItem> _getSelectedItems() {
    return _selectedProducts.entries
        .where(
          (entry) =>
              entry.value > 0 && _selectedProductDetails.containsKey(entry.key),
        )
        .map((entry) {
          final item = _selectedProductDetails[entry.key]!;
          return PreSaleItem(
            productId: item.productId,
            productName: item.productName,
            quantity: entry.value,
            unitPrice: item.unitPrice,
          );
        })
        .toList();
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Sair da conta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tem certeza que deseja sair?\nVocê precisará fazer login novamente.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sair'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (shouldLogout == true && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar produto ou marca...',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    _loadCurrentCharging(search: '');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedInfo() {
    final totalItems = _selectedProducts.values.fold<int>(
      0,
      (sum, q) => sum + q,
    );

    if (totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        // child: Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: Colors.white.withValues(alpha: 0.18),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Text(
        //     '$totalItems item(ns) selecionado(s)',
        //     style: const TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = _getSelectedItems();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.user.name),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildSearchField(),
              _buildSelectedInfo(),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : _currentCharging != null
                    ? ChargingProductsScreen(
                        user: widget.user,
                        charging: _currentCharging!,
                        selectedProducts: _selectedProducts,
                        selectedItems: selectedItems,
                        onQuantityChanged: _updateSelectedProduct,
                        onClearSelection: _clearAllSelectedProducts,
                      )
                    : const Center(
                        child: Text(
                          'Nenhum resultado encontrado',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
