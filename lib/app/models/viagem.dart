class Viagem {
  final int? id;
  final String local;
  final int usuarioId;
  final DateTime dataDePartida;
  final DateTime dataDeRetorno;

  Viagem({
    this.id,
    required this.local,
    required this.usuarioId,
    required this.dataDePartida,
    required this.dataDeRetorno,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'local': local,
      'data_de_partida': dataDePartida,
      'data_de_retorno': dataDeRetorno,
    };
  }

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
      id: json['id'],
      local: json['local'],
      usuarioId: json['usuario_id'],
      dataDePartida: json['data_de_partida'],
      dataDeRetorno: json['data_de_retorno'],
    );
  }
}
