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
    on<CadastrarTaskEvent>(_onCreateTask);
    on<AtualizarTaskEvent>(_onUpdateTask);
    on<AlterarStatusTaskEvent>(_onChangeToPending);
    on<RemoverTaskEvent>(_onDeleteTask);
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

  Future<void> _onCreateTask(CadastrarTaskEvent event, Emitter emit) async {
    emit(SessaoCarregando());
    try {
      final data = await _sessaoService.cadastrar(event.sessao);
      emit(SessaoFinalizada(data));
    } on DioException catch (e) {
      final message = formatarErroValidacao(e);
      emit(SessaoError(message));
    } catch (e) {
      emit(SessaoError(e.toString()));
    }
  }

  Future<void> _onUpdateTask(AtualizarTaskEvent event, Emitter emit) async {
    emit(SessaoCarregando());
    try {
      final data = await _sessaoService.atualizar(event.sessao);
      emit(SessaoFinalizada(data));
    } on DioException catch (e) {
      final message = formatarErroValidacao(e);
      emit(SessaoError(message));
    } catch (e) {
      emit(SessaoError(e.toString()));
    }
  }

  Future<void> _onDeleteTask(RemoverTaskEvent event, Emitter emit) async {
    emit(SessaoCarregando());

    try {
      await _sessaoService.remover(event.sessaoId);
      emit(SessaoFinalizada(event.sessaoId));
    } on DioException catch (e) {
      final message = e.toString();
      emit(SessaoError(message));
    } catch (e) {
      final message = e.toString();
      emit(SessaoError(message));
    }
  }

  Future<void> _onChangeToPending(
    AlterarStatusTaskEvent event,
    Emitter emit,
  ) async {
    emit(SessaoItemCarregando());

    try {
      await _sessaoService.alterarStatus(event.sessaoId, event.status);
      emit(SessaoFinalizada(event.sessaoId));
    } on DioException catch (e) {
      final message = e.toString();
      emit(SessaoError(message));
    } catch (e) {
      final message = e.toString();
      emit(SessaoError(message));
    }
  }
}
