import 'package:flutter/material.dart';
import '../services/json_store_service.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({super.key});

  @override
  State<CadastroClienteScreen> createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();

  void salvarCliente() async {
    if (_formKey.currentState!.validate()) {
      final novoCliente = {
        'nome': nomeController.text,
        'tipo': tipoController.text.toUpperCase(),
        'documento': documentoController.text,
      };

      final clientes = await JsonStorageService.readData('clientes');
      clientes.add(novoCliente);
      await JsonStorageService.writeData('clientes', clientes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente salvo com sucesso!')),
      );

      nomeController.clear();
      tipoController.clear();
      documentoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome *'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tipoController,
                decoration: const InputDecoration(labelText: 'Tipo (F/J) *'),
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  final tipo = value.toUpperCase();
                  if (tipo != 'F' && tipo != 'J') {
                    return 'Informe F ou J';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: documentoController,
                decoration: const InputDecoration(labelText: 'Documento *'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final tipo = tipoController.text.toUpperCase();
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }

                  if (tipo == 'F' && value.length != 11) {
                    return 'CPF deve ter 11 dígitos';
                  }

                  if (tipo == 'J' && value.length != 14) {
                    return 'CNPJ deve ter 14 dígitos';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvarCliente,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
