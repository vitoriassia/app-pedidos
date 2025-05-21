import 'package:dio/dio.dart';
import 'ui_state.dart';

Future<UiState> repositoryHandler<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return SuccessState<T>(result);
  } on DioException catch (e) {
    return ServerErrorState(
      statusCode: e.response?.statusCode,
      message: e.response?.statusMessage ?? 'Erro de servidor',
    );
  } catch (e) {
    return FailureState(message: 'Erro inesperado');
  }
}
