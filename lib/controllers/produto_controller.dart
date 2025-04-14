import 'package:uuid/uuid.dart';
import '../models/produto.dart';
import '../services/json_store_service.dart';

class ProdutoController {
  List<Produto> produtos = [];
  final String _arquivo = 'produtos';

  Future<void> carregarProdutos() async {
    final data = await JsonStorageService.readData(_arquivo);
    produtos = data.map((e) => Produto.fromJson(e)).toList();
  }

  Future<void> salvarProdutos() async {
    final data = produtos.map((e) => e.toJson()).toList();
    await JsonStorageService.writeData(_arquivo, data);
  }

  Future<void> adicionarProduto(Produto produto) async {
    produto.id = const Uuid().v4();
    produtos.add(produto);
    await salvarProdutos();
  }

  Future<void> atualizarProduto(Produto produtoAtualizado) async {
    final index = produtos.indexWhere((p) => p.id == produtoAtualizado.id);
    if (index != -1) {
      produtos[index] = produtoAtualizado;
      await salvarProdutos();
    }
  }

  Future<void> removerProduto(String? id) async {
    if (id != null) {
      produtos.removeWhere((p) => p.id == id);
      await salvarProdutos();
    }
  }
}
