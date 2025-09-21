import 'package:flutter/material.dart';
import 'package:rotacred_app/services/inspector_service.dart';
import '../../model/user.dart';
import '../fiscal/inspector_pending_sales_screen.dart';
import '../../model/dto/inspector_dto.dart';
import '../login_screen.dart';

class InspectorScreen extends StatelessWidget {
  final User user;
  const InspectorScreen({super.key, required this.user});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

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
              title: Row(
                children: [
                  const Text("Fiscal"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      user.name, // 👈 mostra o nome do usuário logado
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sair',
                  onPressed: () => _logout(context),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Pendentes", icon: Icon(Icons.assignment)),
                  Tab(text: "Histórico", icon: Icon(Icons.history)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                InspectorPendingPreSalesScreen(
                  inspectorId: inspector.idInspector,
                ),
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
