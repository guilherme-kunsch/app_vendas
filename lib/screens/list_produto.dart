import 'package:flutter/material.dart';
import '../controllers/produto_controller.dart';
import '../models/produto.dart';
import 'form_produto.dart';
import 'home_screen.dart';

class ListarProdutosScreen extends StatefulWidget {
  const ListarProdutosScreen({super.key});

  @override
  State<ListarProdutosScreen> createState() => _ListarProdutosScreenState();
}

class _ListarProdutosScreenState extends State<ListarProdutosScreen> {
  final ProdutoController controller = ProdutoController();

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    await controller.carregarProdutos();
    setState(() {});
  }

  Future<void> removerProduto(String? id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir produto'),
            content: const Text('Tem certeza que deseja excluir este produto?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await controller.removerProduto(id);
      setState(() {});
    }
  }

  Future<void> editarProduto(Produto produto) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormProduto(produto: produto)),
    );

    if (result == true) {
      await controller.carregarProdutos();
      setState(() {});
    }
  }

  Future<void> novoProduto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormProduto()),
    );

    if (result == true) {
      await controller.carregarProdutos();
      setState(() {});
    }
  }

  void voltarParaHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produtos = controller.produtos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos Cadastrados'),
        actions: [
          IconButton(
            onPressed: voltarParaHome,
            icon: const Icon(Icons.home),
            tooltip: 'Voltar para Home',
          ),
        ],
      ),
      body:
          produtos.isEmpty
              ? const Center(child: Text('Nenhum produto cadastrado.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final p = produtos[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F1F3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        p.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00123C),
                        ),
                      ),
                      subtitle: Text(
                        'Unidade: ${p.unidade} | Estoque: ${p.qtdEstoque}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xFFDC3002),
                        ),
                        onPressed: () => removerProduto(p.id),
                        tooltip: 'Excluir',
                      ),
                      onTap: () => editarProduto(p),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: novoProduto,
        icon: const Icon(Icons.add),
        label: const Text('Novo Produto'),
      ),
    );
  }
}
