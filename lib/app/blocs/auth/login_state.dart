abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final dynamic result;
  LoginSuccessfulState(this.result);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
