import 'package:app_vendas/models/pedido_item.dart';
import 'package:app_vendas/models/pedido_pagamento.dart';

class Pedido {
  int id;
  int clienteId;
  String usuarioId;
  double total;
  DateTime dataCriacao;
  List<PedidoItem> itens;
  List<PedidoPagamento> pagamentos;

  Pedido({
    required this.id,
    required this.clienteId,
    required this.usuarioId,
    required this.total,
    required this.dataCriacao,
    required this.itens,
    required this.pagamentos,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'clienteId': clienteId,
    'usuarioId': usuarioId,
    'total': total,
    'dataCriacao': dataCriacao.toIso8601String(),
    'itens': itens.map((e) => e.toJson()).toList(),
    'pagamentos': pagamentos.map((e) => e.toJson()).toList(),
  };

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
    id: json['id'],
    clienteId: json['clienteId'],
    usuarioId: json['usuarioId'],
    total: json['total'],
    dataCriacao: DateTime.parse(json['dataCriacao']),
    itens: (json['itens'] as List).map((e) => PedidoItem.fromJson(e)).toList(),
    pagamentos:
        (json['pagamentos'] as List)
            .map((e) => PedidoPagamento.fromJson(e))
            .toList(),
  );
}
