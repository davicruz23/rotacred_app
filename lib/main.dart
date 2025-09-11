import 'package:flutter/material.dart';
import 'package:rotacred_app/ui/login_screen.dart';

void main() {
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
