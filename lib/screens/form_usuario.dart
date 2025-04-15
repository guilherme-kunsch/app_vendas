import 'package:flutter/material.dart';
import '../services/json_store_service.dart';

class FormUsuario extends StatefulWidget {
  const FormUsuario({super.key});

  @override
  State<FormUsuario> createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  void _salvarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final novoUsuario = {
        'id': idController.text,
        'nome': nomeController.text,
        'senha': senhaController.text,
      };

      final usuarios = await JsonStorageService.readData('usuarios');
      usuarios.add(novoUsuario);
      await JsonStorageService.writeData('usuarios', usuarios);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário salvo com sucesso!')),
      );

      _formKey.currentState!.reset();
      idController.clear();
      nomeController.clear();
      senhaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID *'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome *'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha *'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarUsuario,
                child: const Text('Salvar Usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
