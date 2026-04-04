import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import '../env/environment.dart';
import '../model/user.dart';
import '../database/database_service.dart';

class LoginException implements Exception {
  final String message;
  LoginException(this.message);

  @override
  String toString() => message;
}

String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class AuthService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<User> login(String cpf, String password) async {
    try {
      print("========================================");
      print("🔐 INICIANDO LOGIN");
      print("CPF enviado: $cpf");
      print("========================================");

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cpf': cpf, 'password': password}),
      );

      print("📡 STATUS RESPONSE: ${response.statusCode}");
      print("📦 BODY RESPONSE:");
      print(response.body);
      print("========================================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        print("🔑 TOKEN RECEBIDO:");
        print(token);
        print("========================================");

        final payloadBase64 = token.split('.')[1];
        final normalized = base64.normalize(payloadBase64);
        final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)));

        print("📄 PAYLOAD JWT:");
        print(payload);
        print("========================================");

        final role = payload['role'];

        print("👤 ROLE: $role");
        print("🆔 payload['id']: ${payload['id']}");
        print("📛 payload['nome']: ${payload['nome']}");
        print("📄 payload['sub']: ${payload['sub']}");
        print("========================================");

        const allowedRoles = {'ROLE_VENDEDOR', 'ROLE_FISCAL', 'ROLE_COBRADOR'};

        if (!allowedRoles.contains(role)) {
          print("⛔ ROLE NÃO PERMITIDA: $role");
          throw LoginException("Usuário não tem permissão para acessar!");
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print("💾 TOKEN SALVO NO STORAGE");

        final user = User()
          ..serverId = payload['id']
          ..cpf = payload['sub']
          ..name = payload['nome']
          ..position = role
          ..passwordHash = hashPassword(password);

        print("========================================");
        print("👤 USUÁRIO CRIADO NO APP");
        print("serverId: ${user.serverId}");
        print("cpf: ${user.cpf}");
        print("name: ${user.name}");
        print("position: ${user.position}");
        print("========================================");

        final isar = DatabaseService.isar;

        await isar.writeTxn(() async {
          print("🗄 Limpando usuários locais...");
          await isar.users.clear();

          print("💾 Salvando usuário no ISAR...");
          await isar.users.put(user);
        });

        print("✅ LOGIN FINALIZADO COM SUCESSO");
        print("========================================");

        return user;
      } else {
        print("❌ ERRO NO LOGIN:");
        print(response.body);

        throw LoginException("Usuário ou senha incorretos!");
      }
    } catch (e) {
      print("========================================");
      print("⚠️ LOGIN ONLINE FALHOU - TENTANDO OFFLINE");
      print("Erro: $e");
      print("========================================");

      final isar = DatabaseService.isar;

      final user = await isar.users.filter().cpfEqualTo(cpf).findFirst();

      if (user != null) {
        final inputHash = hashPassword(password);

        if (user.passwordHash == inputHash) {
          print("✅ LOGIN OFFLINE AUTORIZADO");

          print("📦 USUÁRIO ENCONTRADO NO BANCO LOCAL");
          print("Nome: ${user.name}");
          print("CPF: ${user.cpf}");
          print("Role: ${user.position}");

          return user;
        } else {
          print("❌ SENHA INCORRETA OFFLINE");
          throw LoginException("Senha incorreta!");
        }
      }

      print("❌ USUÁRIO NÃO ENCONTRADO OFFLINE");

      throw LoginException("Sem internet e usuário não encontrado offline!");
    }
  }

  Future<void> logout() async {
    print("🚪 LOGOUT INICIADO");

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    final isar = DatabaseService.isar;

    await isar.writeTxn(() async {
      await isar.users.clear();
    });

    print("✅ LOGOUT FINALIZADO");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("🔑 TOKEN RECUPERADO DO STORAGE:");
    print(token);

    return token;
  }
}
