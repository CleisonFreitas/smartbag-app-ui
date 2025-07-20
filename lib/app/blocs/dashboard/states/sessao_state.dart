import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';

/* class SessaoState {
  final List<Sessao> sessoes;
  final bool carregando;
  final bool concluido;
  final bool ultimaPagina;
  final ListParams params;

  SessaoState({
    required this.sessoes,
    required this.carregando,
    required this.ultimaPagina,
    required this.params,
    required this.concluido,
  });

  factory SessaoState.inicial() {
    return SessaoState(
      sessoes: [],
      carregando: false,
      concluido: true,
      ultimaPagina: false,
      params: ListParams(),
    );
  }

  SessaoState copyWith({
    List<Sessao>? sessoes,
    bool? carregando,
    bool? concluido,
    bool? ultimaPagina,
    ListParams? params,
  }) {
    return SessaoState(
      sessoes: sessoes ?? this.sessoes,
      carregando: carregando ?? this.carregando,
      ultimaPagina: ultimaPagina ?? this.ultimaPagina,
      params: params ?? this.params,
      concluido: concluido ?? this.concluido,
    );
  }
} */

abstract class SessaoState {}

class SessaoInicial extends SessaoState {}

class SessaoCarregando extends SessaoState {}

class SessaoConcluida extends SessaoState {
  final List<Sessao> sessoes;
  final bool ultimaPagina;
  final ListParams params;

  SessaoConcluida({
    required this.sessoes,
    required this.ultimaPagina,
    required this.params,
  });
}

class SessaoError extends SessaoState {
  final String message;
  SessaoError(this.message);
}
