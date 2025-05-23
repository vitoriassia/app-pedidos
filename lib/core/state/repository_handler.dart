import 'package:dio/dio.dart';
import 'ui_state.dart';

/// Executes [action] and wraps the result or error in a [UiState].
Future<UiState> repositoryHandler<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return SuccessState<T>(result);
  } on DioException catch (e) {
    return _handleDioException(e);
  } catch (_) {
    return FailureState(message: 'Unexpected error');
  }
}

UiState _handleDioException(DioException e) {
  final response = e.response;
  final statusCode = response?.statusCode;
  final data = response?.data;

  if (data is Map<String, dynamic>) {
    final title = data['title'] as String? ?? 'Server error';
    final rawErrors = data['errors'] as List<dynamic>? ?? [];
    final message = _formatErrors(title, rawErrors);
    return ServerErrorState(statusCode: statusCode, message: message);
  }

  final message = response?.statusMessage ?? 'Server error';
  return ServerErrorState(statusCode: statusCode, message: message);
}

String _formatErrors(String title, List<dynamic> rawErrors) {
  final buffer = StringBuffer()..writeln(title);
  for (final item in rawErrors) {
    if (item is Map<String, dynamic>) {
      final key = item['key'] as String? ?? '';
      final value = item['value'] as String? ?? '';
      buffer.writeln(key.isNotEmpty ? '$key: $value' : value);
    }
  }
  return buffer.toString().trim();
}
