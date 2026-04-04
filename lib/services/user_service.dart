import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../env/environment.dart';

class UserService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/user/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar usuários');
    }
  }
}
