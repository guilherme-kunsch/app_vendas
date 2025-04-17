import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';
import 'form_usuario.dart';
import 'home_screen.dart';

class ListarUsuariosScreen extends StatefulWidget {
  const ListarUsuariosScreen({super.key});

  @override
  State<ListarUsuariosScreen> createState() => _ListarUsuariosScreenState();
}

class _ListarUsuariosScreenState extends State<ListarUsuariosScreen> {
  final controller = UsuarioController();

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    await controller.carregarUsuarios();
    setState(() {});
  }

  Future<void> remover(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirmar exclusão'),
            content: const Text('Deseja excluir este usuário?'),
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
      await controller.removerUsuario(id);
      setState(() {});
    }
  }

  void editar(Usuario usuario) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormUsuario(usuario: usuario)),
    );

    if (result == true) {
      await controller.carregarUsuarios();
      setState(() {});
    }
  }

  void novoUsuario() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormUsuario()),
    );

    if (result == true) {
      await controller.carregarUsuarios();
      setState(() {});
    }
  }

  void voltarParaHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = controller.usuarios;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Cadastrados'),
        actions: [
          IconButton(
            onPressed: voltarParaHome,
            icon: const Icon(Icons.home),
            tooltip: 'Voltar para Home',
          ),
        ],
      ),
      body:
          usuarios.isEmpty
              ? const Center(child: Text('Nenhum usuário cadastrado.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final u = usuarios[index];
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
                        u.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00123C),
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${u.id}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xFFDC3002),
                        ),
                        onPressed: () => remover(u.id),
                        tooltip: 'Excluir',
                      ),
                      onTap: () => editar(u),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: novoUsuario,
        icon: const Icon(Icons.person_add),
        label: const Text('Novo Usuário'),
      ),
    );
  }
}
