import 'package:flutter/material.dart';
import 'package:rotacred_app/model/user.dart';
import 'package:rotacred_app/ui/home_screen.dart';
import '../services/auth_service.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _login() async {
  setState(() {
    _isLoading = true;
    _error = null;
  });

  try {
    final result = await _authService.login(
      _cpfController.text,
      _passwordController.text,
    );

    final token = result['token'];
    print('Login bem-sucedido: $token');

    Map<String, dynamic> payload = Jwt.parseJwt(token);

    final user = User(
      id: payload['id'],
      name: payload['name'],
      cpf: payload['sub'],
      position: payload['position'],
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user: user),
      ),
    );

  } catch (e) {
    setState(() {
      _error = e.toString();
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

}
