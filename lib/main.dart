import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rotacred_app/database/database_service.dart';
import 'package:rotacred_app/services/network_service.dart';
import 'package:rotacred_app/services/sync_service.dart';
import 'package:rotacred_app/ui/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);

  await DatabaseService.init();

  NetworkService().startListening();

  /// executa sync ao abrir app
  SyncService().syncAll();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RotaCred App',
      home: LoginScreen(),
    );
  }
}