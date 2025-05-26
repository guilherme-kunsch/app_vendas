class Produto {
  String? id;
  String nome;
  String unidade;
  int qtdEstoque;
  double precoVenda;
  int status; // 0 - Ativo, 1 - Inativo
  double? custo;
  String codigoBarra;
  String dataAlteracao;

  Produto({
    this.id,
    required this.nome,
    required this.unidade,
    required this.qtdEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    required this.codigoBarra,
    required this.dataAlteracao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      unidade: json['unidade'],
      qtdEstoque: json['qtdEstoque'],
      precoVenda: (json['precoVenda'] as num).toDouble(),
      status: json['status'],
      custo: json['custo'] != null ? (json['custo'] as num).toDouble() : null,
      codigoBarra: json['codigoBarra'],
      dataAlteracao: json['dataAlteracao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
      'dataAlteracao': dataAlteracao,
    };
  }

  Map<String, dynamic> toSQL() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
      'dataAlteracao': dataAlteracao,
    };
  }
}
