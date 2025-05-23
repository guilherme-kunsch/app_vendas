import '../models/pedido.dart';
import '../services/storage_service.dart';

class PedidoController {
  List<Pedido> pedidos = [];
  final String _arquivo = 'pedidos';

  Future<void> carregarPedidos() async {
    final data = await StorageService.readData(_arquivo);
    pedidos = data.map((e) => Pedido.fromJson(e)).toList();
  }

  Future<void> salvarPedidos() async {
    final data = pedidos.map((e) => e.toJson()).toList();
    await StorageService.writeData(_arquivo, data);
  }

  Future<void> adicionarPedido(Pedido pedido) async {
    pedidos.add(pedido);
    await salvarPedidos();
  }

  Future<void> atualizarPedido(Pedido pedidoAtualizado) async {
    final index = pedidos.indexWhere((p) => p.id == pedidoAtualizado.id);
    if (index != -1) {
      pedidos[index] = pedidoAtualizado;
      await salvarPedidos();
    }
  }

  Future<void> removerPedido(int id) async {
    pedidos.removeWhere((p) => p.id == id);
    await salvarPedidos();
  }

  Pedido getPedidoById(String id) {
    return pedidos.firstWhere(
      (p) => p.id == id,
      orElse: () {
        throw Exception('Pedido não encontrado');
      },
    );
  }
}
