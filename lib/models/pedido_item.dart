class PedidoItem {
  int id;
  String produtoId;
  String? nome;
  double quantidade;
  double total;

  PedidoItem({
    required this.id,
    required this.produtoId,
    required this.nome,
    required this.quantidade,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'produtoId': produtoId,
    'quantidade': quantidade,
    'total': total,
  };

  factory PedidoItem.fromJson(Map<String, dynamic> json) => PedidoItem(
    id: json['id'],
    nome: json['nome'] ?? '',
    produtoId: json['produtoId'] ?? '',
    quantidade: json['quantidade'],
    total: json['total'],
  );
}
