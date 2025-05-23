import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cliente.dart';
import '../services/storage_service.dart';

class ClienteController {
  List<Cliente> clientes = [];

  Future<void> loadClientes() async {
    final data = await StorageService.readData('clientes');
    clientes = data.map((e) => Cliente.fromJson(e)).toList();
  }

  void adicionarCliente(Cliente cliente) {
    cliente.id = clientes.isNotEmpty ? clientes.last.id + 1 : 1;
    clientes.add(cliente);
  }

  void atualizarCliente(int index, Cliente clienteAtualizado) {
    clientes[index] = clienteAtualizado;
  }

  void removerCliente(int index) {
    clientes.removeAt(index);
  }

  Future<void> salvarClientes() async {
    final data = clientes.map((c) => c.toJson()).toList();
    await StorageService.writeData('clientes', data);
  }

  Future<Map<String, String>?> buscarEnderecoPorCEP(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('erro') && data['erro'] == true) {
          return null; // CEP não encontrado
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
      return null;
    }
  }
}
