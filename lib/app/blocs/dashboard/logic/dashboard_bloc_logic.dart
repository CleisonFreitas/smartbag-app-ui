import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/events/dashboard_bloc_events.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/dashboard_bloc_state.dart';
import 'package:mochila_de_viagem/app/blocs/dashboard/states/sessao_state.dart';
import 'package:mochila_de_viagem/app/helper/exception_transform_helper.dart';
import 'package:mochila_de_viagem/app/models/sessao.dart';
import 'package:mochila_de_viagem/app/services/apis/sessoes/sessao_api_service.dart';
import 'package:mochila_de_viagem/app/services/daos/sessoes_dao.dart';

class DashboardBlocLogic extends Bloc<DashboardBlocEvents, SessaoState> {
  final dao = SessoesDao();
  final _sessaoService = SessaoApiService();
  DashboardBlocLogic() : super(SessaoState.inicial()) {
    on<LoadListEvent>(_onLoadList);
  }

  Future<void> _onLoadList(LoadListEvent event, Emitter emit) async {
    emit(state.copyWith(carregando: true, concluido: false));

    try {
      final page = event.reset ? 1 : state.params.page + 1;
      final newParams = event.params.copyWith(page: page);
      final data = await _sessaoService.buscar(newParams);

      final List<Sessao> newItems = data.items;

      emit(
        state.copyWith(
          sessoes: event.reset ? newItems : [...state.sessoes, ...newItems],
          carregando: false,
          ultimaPagina: newItems.length < newParams.perPage,
          params: newParams,
          concluido: true,
        ),
      );
    } on DioException catch (e) {
      final message = formatarErroValidacao(e);

      emit(DashboardErrorState(message));

      emit(state.copyWith(carregando: false));
    } catch (e) {
      emit(state.copyWith(carregando: false, concluido: true));
    }
  }
}
