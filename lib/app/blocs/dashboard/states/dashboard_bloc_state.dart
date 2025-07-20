abstract class DashboardBlocState {}

class DashboardInitialState extends DashboardBlocState {}

class DashboardLoadingState extends DashboardBlocState {}

class DashboardLoadedState extends DashboardBlocState {
  final dynamic data;

  DashboardLoadedState(this.data);
}

class DashboardSuccessfulState extends DashboardBlocState {
  final dynamic response;
  DashboardSuccessfulState(this.response);
}

class DashboardErrorState extends DashboardBlocState {
  final dynamic response;
  DashboardErrorState(this.response);
}
