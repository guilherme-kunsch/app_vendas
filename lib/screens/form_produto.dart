import 'package:flutter/material.dart';
import '../controllers/produto_controller.dart';
import '../models/produto.dart';

class FormProduto extends StatefulWidget {
  final Produto? produto;

  const FormProduto({super.key, this.produto});

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

  @override
  void initState() {
    super.initState();
    final p = widget.produto;
    if (p != null) {
      nomeController.text = p.nome;
      unidadeController.text = p.unidade;
      qtdEstoqueController.text = p.qtdEstoque.toString();
      precoVendaController.text = p.precoVenda.toString();
      statusController.text = p.status.toString();
      custoController.text = p.custo?.toString() ?? '';
      codigoBarraController.text = p.codigoBarra;
    }
  }

  void _salvarProduto() async {
    if (_formKey.currentState!.validate()) {
      final novoProduto = Produto(
        id: widget.produto?.id,
        nome: nomeController.text,
        unidade: unidadeController.text,
        qtdEstoque: int.parse(qtdEstoqueController.text),
        precoVenda: double.parse(precoVendaController.text),
        status: int.parse(statusController.text),
        custo:
            custoController.text.isEmpty
                ? 0.0
                : double.parse(custoController.text),
        codigoBarra: codigoBarraController.text,
      );

      final controller = ProdutoController();
      await controller.carregarProdutos();

      if (widget.produto != null) {
        await controller.atualizarProduto(novoProduto);
      } else {
        await controller.adicionarProduto(novoProduto);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto salvo com sucesso!')),
        );
        Navigator.pop(context, true);
      }
    }
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    TextInputType? teclado,
    bool obrigatorio = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: teclado,
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
            obrigatorio
                ? (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Campo obrigatório'
                        : null
                : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdicao = widget.produto != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdicao ? 'Editar Produto' : 'Cadastrar Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input(
                label: 'Nome *',
                controller: nomeController,
                obrigatorio: true,
              ),
              _input(
                label: 'Unidade *',
                controller: unidadeController,
                obrigatorio: true,
              ),
              _input(
                label: 'Quantidade em Estoque *',
                controller: qtdEstoqueController,
                teclado: TextInputType.number,
                obrigatorio: true,
              ),
              _input(
                label: 'Preço de Venda *',
                controller: precoVendaController,
                teclado: const TextInputType.numberWithOptions(decimal: true),
                obrigatorio: true,
              ),
              _input(
                label: 'Status (0 - Ativo, 1 - Inativo) *',
                controller: statusController,
                teclado: TextInputType.number,
                obrigatorio: true,
              ),
              _input(
                label: 'Custo',
                controller: custoController,
                teclado: const TextInputType.numberWithOptions(decimal: true),
              ),
              _input(
                label: 'Código de Barras',
                controller: codigoBarraController,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _salvarProduto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC3002),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isEdicao ? 'Atualizar Produto' : 'Salvar Produto',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFDC3002)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
