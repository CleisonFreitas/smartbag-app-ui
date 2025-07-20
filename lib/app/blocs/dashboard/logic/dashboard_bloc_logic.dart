import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/events/dashboard_bloc_events.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/sessao_state.dart';
import 'package:mochila_de_viagem/app/helper/exception_transform_helper.dart';
import 'package:mochila_de_viagem/app/services/apis/sessoes/sessao_api_service.dart';
import 'package:mochila_de_viagem/app/services/daos/sessoes_dao.dart';

class DashboardBlocLogic extends Bloc<DashboardBlocEvents, SessaoState> {
  final dao = SessoesDao();
  final _sessaoService = SessaoApiService();
  DashboardBlocLogic() : super(SessaoInicial()) {
    on<LoadListEvent>(_onLoadList);
  }

  Future<void> _onLoadList(LoadListEvent event, Emitter emit) async {
    emit(SessaoCarregando());

    try {
      final data = await _sessaoService.buscar(event.params);
      emit(
        SessaoConcluida(
          sessoes: data.items,
          ultimaPagina: data.items.length < event.params.perPage,
          params: event.params,
        ),
      );
    } on DioException catch (e) {
      final message = formatarErroValidacao(e);

      emit(SessaoError(message));
    } catch (e) {
      emit(SessaoError(e.toString()));
    }
  }
}
