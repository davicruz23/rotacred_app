import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../fiscal/inspector_pending_sales_screen.dart';

class InspectorScreen extends StatelessWidget {
  final User user;
  const InspectorScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fiscal - ${user.name}")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bem-vindo Fiscal!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Botão para pré-vendas pendentes
              ElevatedButton.icon(
                icon: const Icon(Icons.assignment),
                label: const Text("Pré-vendas Pendentes"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InspectorPendingPreSalesScreen(
                        inspectorId: user.id, // pega o id do usuário fiscal
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              // futuro: adicionar outros botões (ex: histórico de inspeções, relatórios, etc)
            ],
          ),
        ),
      ),
    );
  }
}
