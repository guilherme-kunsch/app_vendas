import '../models/cliente.dart';
import '../services/database_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClienteController {
  Future<void> salvarCliente(Cliente cliente) async {
    final db = await BancoHelper().db;
    cliente.dataAlteracao = DateTime.now().toIso8601String();

    if (cliente.id == null) {
      cliente.id = await db.insert('Cliente', cliente.toSQL());
    } else {
      await db.update(
        'Cliente',
        cliente.toSQL(),
        where: 'id = ?',
        whereArgs: [cliente.id],
      );
    }
  }

  Future<void> excluirCliente(int id) async {
    final db = await BancoHelper().db;
    await db.delete('Cliente', where: 'id = ?', whereArgs: [id]);
  }

  // Renomeado para manter o padrão
  Future<List<Cliente>> loadClientes() async {
    final db = await BancoHelper().db;
    final maps = await db.query('Cliente');
    return List.generate(maps.length, (i) => Cliente.fromJson(maps[i]));
  }

  Future<Map<String, dynamic>?> buscarEnderecoPorCEP(String cep) async {
    try {
      final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['erro'] == true) {
          return null;
        }
        return {
          'endereco': data['logradouro'] ?? '',
          'bairro': data['bairro'] ?? '',
          'cidade': data['localidade'] ?? '',
          'uf': data['uf'] ?? '',
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar CEP: $e');
      return null;
    }
  }
}
