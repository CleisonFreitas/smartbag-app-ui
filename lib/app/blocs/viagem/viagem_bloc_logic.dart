import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/viagem/viagem_bloc_event.dart';
import 'package:mochila_de_viagem/app/blocs/viagem/viagem_bloc_state.dart';
import 'package:mochila_de_viagem/app/models/viagem.dart';

class ViagemBlocLogic extends Bloc<ViagemBlocEvent, ViagemBlocState> {
  ViagemBlocLogic() : super(ViagemBlocInitialState()) {
    on<SubmitViagemBlocEvent>(_onSubmitEvent);
    on<ListViagemBlocEvent>(_onListEvent);
    on<ShowViagemBlocEvent>(_onShowEvent);
  }

  Future<void> _onSubmitEvent(SubmitViagemBlocEvent event, Emitter emit) async {
    emit(ViagemBlocLoadingState());

    try {
      /// Adicionar lógica da API aqui
      emit(ViagemBlocLoadedState(event.viagem));
    } catch (e) {
      ViagemBlocErrorState(e.toString());
      rethrow;
    }
  }

  Future<void> _onListEvent(ListViagemBlocEvent event, Emitter emit) async {
    emit(ViagemBlocLoadingState());

    try {
      final lista = event.viagens;
      emit(ViagemBlocLoadedState(lista));
    } catch (e) {
      emit(ViagemBlocErrorState(e.toString()));
      rethrow;
    }
  }

  Future<void> _onShowEvent(ShowViagemBlocEvent event, Emitter emit) async {
    emit(ViagemBlocLoadingState());
    try {
      final Viagem viagem = event.viagem;
      emit(ViagemBlocLoadedState(viagem));
    } catch (e) {
      emit(ViagemBlocErrorState(e.toString()));
      rethrow;
    }
  }
}
