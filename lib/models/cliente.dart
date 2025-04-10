class Cliente {
  int id;
  String nome;
  String tipo; // 'F' ou 'J'
  String documento;
  String? email;
  String? telefone;
  String? cep;
  String? endereco;
  String? bairro;
  String? cidade;
  String? uf;

  Cliente({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.documento,
    this.email,
    this.telefone,
    this.cep,
    this.endereco,
    this.bairro,
    this.cidade,
    this.uf,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      documento: json['documento'],
      email: json['email'],
      telefone: json['telefone'],
      cep: json['cep'],
      endereco: json['endereco'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'tipo': tipo,
        'documento': documento,
        'email': email,
        'telefone': telefone,
        'cep': cep,
        'endereco': endereco,
        'bairro': bairro,
        'cidade': cidade,
        'uf': uf,
      };
}
