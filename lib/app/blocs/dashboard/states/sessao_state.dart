import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';

abstract class SessaoState {}

class SessaoInicial extends SessaoState {}

class SessaoCarregando extends SessaoState {}

// Utilizada para conclusão de forms
class SessaoFinalizada extends SessaoState {
  final dynamic response;
  SessaoFinalizada(this.response);
}

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
