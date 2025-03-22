abstract class AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final dynamic data;
  AppLoaded(this.data);
}

class AppError extends AppState {
  final String? message;
  AppError(this.message);
}

abstract class AppEvent {}
