import 'package:mochila_de_viagem/app/models/cliente.dart';

abstract class RegistrarBlocEvent {}

class SubmitRegistrarEvent extends RegistrarBlocEvent {
  final Cliente cliente;
  SubmitRegistrarEvent(this.cliente);
}
