import 'package:mochila_de_viagem/app/helper/list_params.dart';

sealed class DashboardBlocEvents {}

class LoadListEvent extends DashboardBlocEvents {
  final bool reset;
  final ListParams params;

  LoadListEvent(this.params, this.reset);
}
