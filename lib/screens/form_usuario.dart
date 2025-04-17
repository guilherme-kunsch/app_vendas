import 'package:flutter/material.dart';
import '../controllers/usuario_controller.dart';
import '../models/usuario.dart';

class FormUsuario extends StatefulWidget {
  final Usuario? usuario;
  final int? index;

  const FormUsuario({super.key, this.usuario, this.index});

  @override
  State<FormUsuario> createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final controller = UsuarioController();

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      nomeController.text = widget.usuario!.nome;
      senhaController.text = widget.usuario!.senha;
    }
    controller.carregarUsuarios();
  }

  void salvar() async {
    if (_formKey.currentState!.validate()) {
      final usuario = Usuario(
        id: widget.usuario?.id ?? '',
        nome: nomeController.text,
        senha: senhaController.text,
      );

      if (widget.usuario != null) {
        await controller.atualizarUsuario(usuario);
      } else {
        await controller.adicionarUsuario(usuario.nome, usuario.senha);
      }

      if (context.mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF0F1F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Campo obrigatório' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdicao = widget.usuario != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar Usuário' : 'Cadastrar Usuário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input(label: 'Nome *', controller: nomeController),
              _input(
                label: 'Senha *',
                controller: senhaController,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDC3002),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEdicao ? 'Atualizar Usuário' : 'Salvar Usuário',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
