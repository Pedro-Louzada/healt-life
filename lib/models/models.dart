class AlimentosModel {

  String nome;
  String foto;
  String categoria;
  String tipo;

  AlimentosModel({
    required this.nome,
    required this.foto,
    required this.categoria,
    required this.tipo
    
  });

  Map<String, dynamic> toMaps() {
    return {
      'nome': nome,
      'foto': foto,
      'categoria': categoria,
      'tipo': tipo
    };
  }
}