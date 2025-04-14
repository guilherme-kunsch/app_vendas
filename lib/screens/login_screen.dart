import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Login realizado com sucesso!')));

    // Navega para a HomeScreen substituindo a tela atual (LoginScreen)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Usuário'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe o nome'
                            : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe a senha'
                            : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _fazerLogin, child: Text('Entrar')),
            ],
          ),
        ),
      ),
    );
  }
}
