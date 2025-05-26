import 'package:uuid/uuid.dart';
import '../models/produto.dart';
import '../services/database_helper.dart';

class ProdutoController {
  Future<void> salvarProduto(Produto produto) async {
    final db = await BancoHelper().db;
    produto.dataAlteracao = DateTime.now().toIso8601String();

    // Se não tiver ID, gera um novo
    produto.id ??= const Uuid().v4();

    // Verifica se já existe
    final existe = await db.query(
      'Produto',
      where: 'id = ?',
      whereArgs: [produto.id],
    );

    if (existe.isEmpty) {
      await db.insert('Produto', produto.toSQL());
    } else {
      await db.update(
        'Produto',
        produto.toSQL(),
        where: 'id = ?',
        whereArgs: [produto.id],
      );
    }
  }

  Future<void> removerProduto(String id) async {
    final db = await BancoHelper().db;
    await db.delete('Produto', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Produto>> listarProdutos() async {
    final db = await BancoHelper().db;
    final maps = await db.query('Produto');
    return List.generate(maps.length, (i) => Produto.fromJson(maps[i]));
  }
}
