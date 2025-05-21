abstract class UiState {}

class InitialState extends UiState {}

class LoadingState extends UiState {}

class SuccessState<T> extends UiState {
  final T data;

  SuccessState(this.data);
}

class FailureState extends UiState {
  final String message;

  FailureState({this.message = 'Erro desconhecido'});
}

class ServerErrorState extends FailureState {
  final int? statusCode;

  ServerErrorState({this.statusCode, required super.message});
}

/// Handler for different UI states.
///
/// [state]: The UI state to handle.
/// [onSuccess]: Callback function for handling [Success<T>] state.
/// [onServerError]: Callback function for handling [ServerErrorState] state.
/// [onFailure]: Callback function for handling [FailureState] state.
void handlerUiStates<T>(
  UiState state, {
  Function(SuccessState<T> success)? onSuccess,
  Function(ServerErrorState serverError)? onServerError,
  Function(FailureState failureState)? onFailure,
}) {
  if (state is SuccessState<T>) {
    onSuccess?.call(state);
  } else if (state is FailureState) {
    onFailure?.call(state);
  }
}
