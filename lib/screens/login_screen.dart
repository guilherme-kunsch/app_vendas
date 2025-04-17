import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioController = UsuarioController();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  Future<void> _carregarUsuarios() async {
    await _usuarioController.carregarUsuarios();
    setState(() {
      _carregando = false;
    });
  }

  void _fazerLogin() {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final senha = _senhaController.text;

      if (_usuarioController.usuarios.isEmpty &&
          nome == 'admin' &&
          senha == 'admin') {
        _navegarParaHome();
        return;
      }

      final usuario = _usuarioController.validarLogin(nome, senha);
      if (usuario != null && usuario.id.isNotEmpty) {
        _navegarParaHome();
      } else {
        _mostrarErro('Usuário ou senha inválidos');
      }
    }
  }

  void _navegarParaHome() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login realizado com sucesso!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: const Color(0xFFDC3002),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo central
                Image.asset('assets/logo_mastigadores.png', height: 180),
                const SizedBox(height: 32),

                // Campos
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe o nome'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe a senha'
                              : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _fazerLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC3002),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
