import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_event.dart';
import 'package:mochila_de_viagem/app/blocs/auth/login_state.dart';
import 'package:mochila_de_viagem/app/helper/exception_transform_helper.dart';
import 'package:mochila_de_viagem/app/services/apis/clientes/cliente_api_service.dart';

class LoginLogic extends Bloc<LoginEvent, LoginState> {
  final _clienteService = ClienteApiService();
  LoginLogic() : super(LoginInitialState()) {
    on<SubmitLoginEvent>(_submitLoginEvent);
    on<ShowUsuarioEvent>(_showUsuarioEvent);
  }

  Future<void> _submitLoginEvent(SubmitLoginEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      final Map<String, dynamic> dataMapped = {
        'email': event.email,
        'senha': event.senha,
      };
      final data = await _clienteService.loginCliente(dataMapped);
      emit(LoginSuccessfulState(data));
    } on DioException catch (e) {
      final mensagem = formatarErroValidacao(e);
      emit(LoginErrorState(mensagem));
      rethrow;
    }
  }

  Future<void> _showUsuarioEvent(ShowUsuarioEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      // TODO: Implementar lógica.
      emit(LoginSuccessfulState('Dados processados com sucesso!'));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
      rethrow;
    }
  }
}
