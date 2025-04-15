import 'package:flutter/material.dart';
import '../services/json_store_service.dart';

class FormProduto extends StatefulWidget {
  const FormProduto({super.key});

  @override
  State<FormProduto> createState() => _FormProdutoState();
}

class _FormProdutoState extends State<FormProduto> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final unidadeController = TextEditingController();
  final qtdEstoqueController = TextEditingController();
  final precoVendaController = TextEditingController();
  final statusController = TextEditingController();
  final custoController = TextEditingController();
  final codigoBarraController = TextEditingController();

  void _salvarProduto() async {
    if (_formKey.currentState!.validate()) {
      final novoProduto = {
        'nome': nomeController.text,
        'unidade': unidadeController.text,
        'qtdEstoque': int.parse(qtdEstoqueController.text),
        'precoVenda': double.parse(precoVendaController.text),
        'status': int.parse(statusController.text),
        'custo':
            custoController.text.isEmpty
                ? 0.0
                : double.parse(custoController.text),
        'codigoBarra': codigoBarraController.text,
      };

      final produtos = await JsonStorageService.readData('produtos');
      produtos.add(novoProduto);
      await JsonStorageService.writeData('produtos', produtos);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );

      _formKey.currentState!.reset();
      nomeController.clear();
      unidadeController.clear();
      qtdEstoqueController.clear();
      precoVendaController.clear();
      statusController.clear();
      custoController.clear();
      codigoBarraController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                controller: unidadeController,
                decoration: const InputDecoration(labelText: 'Unidade *'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              TextFormField(
                controller: qtdEstoqueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade em Estoque *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Campo obrigatório';
                  if (int.tryParse(value) == null) return 'Número inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: precoVendaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Preço de Venda *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Campo obrigatório';
                  if (double.tryParse(value) == null) return 'Número inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: statusController,
                decoration: const InputDecoration(
                  labelText: 'Status (0 - Ativo, 1 - Inativo) *',
                ),
                validator: (value) {
                  if (value == null || (value != '0' && value != '1')) {
                    return 'Informe 0 ou 1';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: custoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Custo'),
              ),
              TextFormField(
                controller: codigoBarraController,
                decoration: const InputDecoration(
                  labelText: 'Código de Barras *',
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarProduto,
                child: const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
