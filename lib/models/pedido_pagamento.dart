class PedidoPagamento {
  int id;
  double valorPagamento;

  PedidoPagamento({required this.id, required this.valorPagamento});

  Map<String, dynamic> toJson() => {'id': id, 'valorPagamento': valorPagamento};

  factory PedidoPagamento.fromJson(Map<String, dynamic> json) =>
      PedidoPagamento(id: json['id'], valorPagamento: json['valorPagamento']);
}
