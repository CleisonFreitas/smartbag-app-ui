import 'package:mochila_de_viagem/app/helper/list_params.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';

sealed class DashboardBlocEvents {}

class LoadListEvent extends DashboardBlocEvents {
  final bool reset;
  final ListParams params;

  LoadListEvent(this.params, this.reset);
}

class CadastrarTaskEvent extends DashboardBlocEvents {
  final Sessao sessao;
  CadastrarTaskEvent(this.sessao);
}

class AtualizarTaskEvent extends DashboardBlocEvents {
  final Sessao sessao;
  AtualizarTaskEvent(this.sessao);
}
