import 'package:flutter/material.dart';
import 'form_client.dart';
import 'form_produto.dart';
import 'form_usuario.dart';
import 'list_client.dart';
import 'list_produto.dart';
import 'list_usuario.dart';
import '../controllers/cliente_controller.dart';
import '../controllers/produto_controller.dart';
import '../controllers/usuario_controller.dart';
import 'login_screen.dart';
import '../components/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final clienteController = ClienteController();
  final produtoController = ProdutoController();
  final usuarioController = UsuarioController();

  int totalClientes = 0;
  int totalProdutos = 0;
  int totalUsuarios = 0;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    await clienteController.loadClientes();
    await produtoController.carregarProdutos();
    await usuarioController.carregarUsuarios();

    setState(() {
      totalClientes = clienteController.clientes.length;
      totalProdutos = produtoController.produtos.length;
      totalUsuarios = usuarioController.usuarios.length;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem vindo(a)'), centerTitle: true),
      drawer: buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: _carregarDados,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _resumoCard('Produtos', totalProdutos, Icons.inventory_2),
                  _resumoCard('Clientes', totalClientes, Icons.people),
                  _resumoCard('Usuários', totalUsuarios, Icons.person),
                ],
              ),
              const SizedBox(height: 32),
              _menuButton(
                'Produtos',
                Icons.inventory_2_outlined,
                const ListarProdutosScreen(),
              ),
              const SizedBox(height: 16),
              _menuButton(
                'Clientes',
                Icons.people_outline,
                const ListarClientesScreen(),
              ),
              const SizedBox(height: 16),
              _menuButton(
                'Usuários',
                Icons.person_outline,
                const ListarUsuariosScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resumoCard(String label, int total, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F1F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: const Color(0xFF00123C)),
            const SizedBox(height: 8),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00123C),
              ),
            ),
            Text(label, style: const TextStyle(color: Color(0xFF00123C))),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(String label, IconData icon, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
          _carregarDados(); // Atualiza ao voltar
        },
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDC3002),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
