import 'package:flutter/material.dart';
import 'package:rotacred_app/ui/collector/collector_screen.dart';
import 'package:rotacred_app/ui/fiscal/inspector_screen.dart';
import 'package:rotacred_app/ui/seller/seller_screen.dart';

import '../model/user.dart';
import '../services/seller_service.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SellerService _sellerService = SellerService();

  @override
  void initState() {
    super.initState();
    _syncInitialData();
  }

  Future<void> _syncInitialData() async {
    try {
      if (widget.user.position == 'ROLE_VENDEDOR') {
        await _sellerService.getSellerByUserId(widget.user.serverId);
        print("✔ Seller sincronizado com sucesso");
      }
    } catch (e) {
      print("⚠ Não foi possível sincronizar seller: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.user.position) {
      case 'ROLE_VENDEDOR':
        return SellerScreen(user: widget.user);

      case 'ROLE_FISCAL':
        return InspectorScreen(user: widget.user);

      case 'ROLE_COBRADOR':
        return CollectorScreen(user: widget.user);

      default:
        return Scaffold(
          body: Center(
            child: Text('Tela não implementada para ${widget.user.position}'),
          ),
        );
    }
  }
}
