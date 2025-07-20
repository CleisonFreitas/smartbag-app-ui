abstract class RegistrarBlocState {}

class RegistrarInitialState extends RegistrarBlocState {}

class RegistrarLoadingState extends RegistrarBlocState {}

class RegistrarSuccessfulState extends RegistrarBlocState {
  final dynamic response;
  RegistrarSuccessfulState(this.response);
}

class RegistrarErrorState extends RegistrarBlocState {
  final String response;
  RegistrarErrorState(this.response);
}

