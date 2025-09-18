import 'package:flutter/material.dart';

class PreSaleDetailScreen extends StatelessWidget {
  final int preSaleId;
  const PreSaleDetailScreen({super.key, required this.preSaleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pré-venda #$preSaleId")),
      body: const Center(
        child: Text("Pegar dados da venda aqui"),
      ),
    );
  }
}
