import 'package:flutter/material.dart';
import 'package:rotacred_app/services/collector_service.dart';
import 'package:rotacred_app/services/inspector_service.dart';
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
  final InspectorService _inspectorService = InspectorService();
  final CollectorService _collectorService = CollectorService();

  @override
  void initState() {
    super.initState();
    _syncInitialData();
  }

  Future<void> _syncInitialData() async {
    try {
      if (widget.user.position == 'ROLE_VENDEDOR') {
        await _sellerService.getSellerByUserId(widget.user.serverId);
        print("✔ Vendedor sincronizado com sucesso");
      } else if (widget.user.position == 'ROLE_FISCAL') {
        await _inspectorService.getPendingPreSales(widget.user.serverId);
        print("✔ Fiscal sincronizado com sucesso");
      } else if (widget.user.position == 'ROLE_COBRADOR') {
        await _collectorService.getCollectorByUserId(widget.user.serverId);
        print("✔ Cobrador sincronizado com sucesso");
      }
    } catch (e) {
      print("Não foi possível sincronizar: $e");
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
