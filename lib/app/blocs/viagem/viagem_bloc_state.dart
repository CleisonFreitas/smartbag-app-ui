abstract class ViagemBlocState {}

class ViagemBlocInitialState extends ViagemBlocState {}

class ViagemBlocLoadingState extends ViagemBlocState {}

class ViagemBlocLoadedState extends ViagemBlocState {
  final dynamic result;
  ViagemBlocLoadedState(this.result);
}

class ViagemBlocErrorState extends ViagemBlocState {
  final String response;
  ViagemBlocErrorState(this.response);
}
