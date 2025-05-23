import 'package:flutter/material.dart';
import '../controllers/cliente_controller.dart';
import '../models/cliente.dart';
import 'form_client.dart';
import 'home_screen.dart';
import '../components/drawer_menu.dart';

class ListarClientesScreen extends StatefulWidget {
  const ListarClientesScreen({super.key});

  @override
  State<ListarClientesScreen> createState() => _ListarClientesScreenState();
}

class _ListarClientesScreenState extends State<ListarClientesScreen> {
  final controller = ClienteController();

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    await controller.loadClientes();
    setState(() {});
  }

  void remover(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Excluir cliente'),
            content: const Text('Tem certeza que deseja excluir este cliente?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      controller.removerCliente(index);
      await controller.salvarClientes();
      setState(() {});
    }
  }

  void editar(int index, Cliente cliente) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroClienteScreen(cliente: cliente, index: index),
      ),
    );

    if (result == true) {
      await controller.loadClientes();
      setState(() {});
    }
  }

  void novoCliente() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroClienteScreen()),
    );

    if (result == true) {
      await controller.loadClientes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientes = controller.clientes;

    return Scaffold(
      appBar: AppBar(title: const Text('Clientes Cadastrados')),
      drawer: DrawerCustom(),
      body:
          clientes.isEmpty
              ? const Center(child: Text('Nenhum cliente cadastrado.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: clientes.length,
                itemBuilder: (context, index) {
                  final c = clientes[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F1F3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        c.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00123C),
                        ),
                      ),
                      subtitle: Text(
                        '${c.tipo == 'F' ? 'CPF' : 'CNPJ'}: ${c.documento}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xFFDC3002),
                        ),
                        onPressed: () => remover(index),
                        tooltip: 'Excluir',
                      ),
                      onTap: () => editar(index, c),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: novoCliente,
        icon: const Icon(Icons.person_add),
        label: const Text('Novo Cliente'),
      ),
    );
  }
}
