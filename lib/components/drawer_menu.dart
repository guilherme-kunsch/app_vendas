import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/list_client.dart';
import '../screens/list_produto.dart';
import '../screens/list_usuario.dart';
import '../screens/login_screen.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Color(0xFF00123C)),
          child: Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _drawerItem(
          icon: Icons.home,
          text: 'Home',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
        _drawerItem(
          icon: Icons.inventory_2,
          text: 'Produtos',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ListarProdutosScreen()),
              (route) => false,
            );
          },
        ),
        _drawerItem(
          icon: Icons.people,
          text: 'Clientes',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ListarClientesScreen()),
              (route) => false,
            );
          },
        ),
        _drawerItem(
          icon: Icons.person,
          text: 'Usuários',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ListarUsuariosScreen()),
              (route) => false,
            );
          },
        ),
        const Spacer(),
        const Divider(),
        _drawerItem(
          icon: Icons.logout,
          text: 'Sair',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}

Widget _drawerItem({
  required IconData icon,
  required String text,
  required Function() onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF00123C)),
    title: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF00123C),
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
  );
}
