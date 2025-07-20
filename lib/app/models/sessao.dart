import 'package:mochila_de_viagem/app/enums/segmento_enum.dart';
import 'package:mochila_de_viagem/app/enums/sessao_status_enum.dart';

class Sessao {
  final int? id;
  final String titulo;
  final SegmentoEnum segmentoEnum;
  final DateTime? previsao;
  final SessaoStatusEnum status;
  final int? usuarioId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Sessao({
    this.id,
    this.previsao,
    required this.titulo,
    required this.segmentoEnum,
    this.status = SessaoStatusEnum.pendente,
    this.usuarioId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sessao.fromJson(Map<String, dynamic> json) {
    return Sessao(
      id: json['id'],
      previsao: DateTime.parse(json['previsao']),
      titulo: json['titulo'] ?? '',
      segmentoEnum: SegmentoEnum.fromTitulo(json['segmento']),
      status: SessaoStatusEnum.fromStatusInformado(json['status']),
      usuarioId: json['usuario_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'segmento': segmentoEnum.titulo,
      'status': status,
      'previsao': previsao,
      'usuario_id': usuarioId,
    };
  }

  @override
  String toString() =>
      'Sessao(id: $id, titulo: $titulo, segmento: $segmentoEnum,  previsao: $previsao)';
}
