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
            body: Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    "Erro: ${snapshot.error}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final inspector = snapshot.data!;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: Row(
                children: [
                  const Icon(Icons.badge, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Fiscal - ${user.name}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Sair',
                  onPressed: () => _logout(context),
                ),
              ],
              bottom: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: [
                  Tab(icon: Icon(Icons.assignment), text: "Pendentes"),
                  Tab(icon: Icon(Icons.history), text: "Histórico"),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
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
