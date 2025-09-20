import 'package:flutter/material.dart';
import 'package:rotacred_app/services/inspector_service.dart';
import '../../model/user.dart';
import '../fiscal/inspector_pending_sales_screen.dart';
import '../../model/dto/inspector_dto.dart';

class InspectorScreen extends StatelessWidget {
  final User user;
  const InspectorScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InspectorDTO>(
      future: InspectorService().getInspectorByUserId(user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Erro: ${snapshot.error}")));
        }

        final inspector = snapshot.data!;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Fiscal - ${user.name}"),
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Pendentes", icon: Icon(Icons.assignment)),
                  Tab(text: "Histórico", icon: Icon(Icons.history)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Aba 1: pré-vendas pendentes
                InspectorPendingPreSalesScreen(
                  inspectorId: inspector.idInspector, // ✅ agora sim o ID certo
                ),

                // Aba 2: histórico
                const Center(
                  child: Text(
                    "Histórico em construção...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
