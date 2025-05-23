import 'package:flutter/material.dart';
import '../screens/list_client.dart';
import '../screens/list_produto.dart';
import '../screens/list_usuario.dart';
import '../screens/list_pedidos.dart';
import '../screens/home_screen.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF00123C)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Produtos'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListarProdutosScreen(),
                  ),
                ),
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Clientes'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListarClientesScreen(),
                  ),
                ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Usuários'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListarUsuariosScreen(),
                  ),
                ),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Pedidos'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ListarPedidosScreen(),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
