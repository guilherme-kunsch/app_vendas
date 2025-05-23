class Configuracao {
  String linkServidor;

  Configuracao({required this.linkServidor});

  factory Configuracao.fromJson(Map<String, dynamic> json) {
    return Configuracao(linkServidor: json['linkServidor']);
  }

  Map<String, dynamic> toJson() {
    return {'linkServidor': linkServidor};
  }
}
