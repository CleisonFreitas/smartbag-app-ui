import 'package:mochila_de_viagem/app/models/viagem.dart';

abstract class ViagemBlocEvent {}

class SubmitViagemBlocEvent extends ViagemBlocEvent {
  final Viagem viagem;
  SubmitViagemBlocEvent(this.viagem);
}

class ListViagemBlocEvent extends ViagemBlocEvent {
  final List<Viagem> viagens;
  ListViagemBlocEvent(this.viagens);
}

class ShowViagemBlocEvent extends ViagemBlocEvent {
  final Viagem viagem;
  ShowViagemBlocEvent(this.viagem);
}
