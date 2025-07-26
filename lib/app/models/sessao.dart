import 'package:mochila_de_viagem/app/enums/segmento_enum.dart';
import 'package:mochila_de_viagem/app/enums/sessao_status_enum.dart';

class Sessao {
  final int? id;
  final String titulo;
  final String? descricao;
  final SegmentoEnum segmentoEnum;
  final DateTime? previsao;
  final SessaoStatusEnum status;
  final int? usuarioId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Sessao({
    this.id,
    this.previsao,
    this.descricao,
    required this.titulo,
    required this.segmentoEnum,
    this.status = SessaoStatusEnum.pendente,
    this.usuarioId,
    this.createdAt,
    this.updatedAt,
  });

  factory Sessao.fromJson(Map<String, dynamic> json) {
    return Sessao(
      id: json['id'],
      previsao: _gerarTimestamp(json['previsao']),
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      segmentoEnum: SegmentoEnum.fromTitulo(json['segmento']),
      status: SessaoStatusEnum.fromStatusInformado(json['status']),
      usuarioId: json['usuario_id'],
      createdAt: _gerarTimestamp(json['created_at']),
      updatedAt: _gerarTimestamp(json['updated_at']),
    );
  }

  static DateTime? _gerarTimestamp(String? data) {
    if (data != null && data.isNotEmpty) {
      return DateTime.parse(data);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'segmento': segmentoEnum.titulo,
      'status': status.titulo,
      'previsao': previsao?.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'Sessao(id: $id, titulo: $titulo, descricao: $descricao,  segmento: $segmentoEnum, previsao: $previsao), status: $status';
}
