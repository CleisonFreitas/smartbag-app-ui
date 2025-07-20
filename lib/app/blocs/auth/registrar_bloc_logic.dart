import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_event.dart';
import 'package:mochila_de_viagem/app/blocs/auth/registrar_bloc_state.dart';
import 'package:mochila_de_viagem/app/helper/exception_transform_helper.dart';
import 'package:mochila_de_viagem/app/services/apis/clientes/cliente_api_service.dart';

class RegistrarBlocLogic extends Bloc<RegistrarBlocEvent, RegistrarBlocState> {
  final _clienteService = ClienteApiService();
  RegistrarBlocLogic() : super(RegistrarInitialState()) {
    on<SubmitRegistrarEvent>(_formRegistrar);
  }

  Future<void> _formRegistrar(SubmitRegistrarEvent evento, Emitter emit) async {
    emit(RegistrarLoadingState());
    try {
      final newCliente = await _clienteService.cadastraCliente(evento.cliente);
      emit(RegistrarSuccessfulState(newCliente));
    } on DioException catch (e) {
      final message = formatarErroValidacao(e);
      emit(RegistrarErrorState(message));
    }
  }
}
