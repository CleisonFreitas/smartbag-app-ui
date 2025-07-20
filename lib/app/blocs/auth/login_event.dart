import 'package:mochila_de_viagem/app/models/usuario.dart';

abstract class LoginEvent {}

class SubmitLoginEvent extends LoginEvent {
  final String email;
  final String senha;

  SubmitLoginEvent(this.email, this.senha);
}

class ShowUsuarioEvent extends LoginEvent {
  final Usuario usuario;
  ShowUsuarioEvent(this.usuario);
}
