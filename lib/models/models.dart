class AlimentosModel {
  String nome = '';
  String foto = '';
  String categoria = '';
  String tipo = '';

  AlimentosModel(
      {required this.nome,
      required this.foto,
      required this.categoria,
      required this.tipo});

  factory AlimentosModel.fromJson(Map<String, dynamic> json) => AlimentosModel(
      nome: json['nome'],
      foto: json['foto'],
      categoria: json['categoria'],
      tipo: json['tipo']);

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "foto": foto,
    "categoria": categoria,
    "tipo": tipo
  };
}

//  Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['nome'] = nome;
//     data['foto'] = foto;
//     data['categoria'] = categoria;
//     data['tipo'] = tipo;
//     return data;
//   }
