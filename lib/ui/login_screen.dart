import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rotacred_app/ui/home_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool _isLoading = false;
  bool _rememberCpf = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadCpf();
  }

  Future<void> _loadCpf() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCpf = prefs.getString('cpf');

    if (savedCpf != null) {
      _cpfController.text = savedCpf;
      setState(() => _rememberCpf = true);
    }
  }

  Future<void> _saveCpf() async {
    final prefs = await SharedPreferences.getInstance();

    if (_rememberCpf) {
      await prefs.setString('cpf', _cpfController.text);
    } else {
      await prefs.remove('cpf');
    }
  }

  bool _isValidCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    int calcDigit(String base, int factor) {
      int total = 0;
      for (int i = 0; i < base.length; i++) {
        total += int.parse(base[i]) * factor--;
      }
      int mod = total % 11;
      return mod < 2 ? 0 : 11 - mod;
    }

    final d1 = calcDigit(cpf.substring(0, 9), 10);
    final d2 = calcDigit(cpf.substring(0, 10), 11);

    return cpf.endsWith('$d1$d2');
  }

  bool get _isFormValid {
    return _isValidCpf(_cpfController.text) &&
        _passwordController.text.length >= 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    Image.asset('assets/logoo2.png', height: 330),

                    //const SizedBox(height: 10),

                    const Text(
                      'Acesso ao Sistema',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // CPF
                            TextFormField(
                              controller: _cpfController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [_cpfMask],
                              decoration: InputDecoration(
                                labelText: 'CPF',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (!_isValidCpf(value ?? '')) {
                                  return 'CPF inválido';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // SENHA
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // LEMBRAR CPF
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberCpf,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberCpf = value!;
                                    });
                                  },
                                ),
                                const Text('Lembrar CPF'),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // BOTÃO
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFormValid
                                      ? const Color(0xFF0D47A1)
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: (!_isFormValid || _isLoading)
                                    ? null
                                    : _login,
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _saveCpf();

      final cpf = _cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');

      final user = await _authService.login(cpf, _passwordController.text);

      if (!mounted) return;

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Login realizado com sucesso')),
      // );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CPF ou senha inválidos')));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
