import 'package:dio/dio.dart';
import 'package:pedidos_app/core/storage/token_storage.dart';
import '../../../features/oauth/model/repository/oauth_repository.dart';
import 'package:pedidos_app/main.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final OAuthRepository _oauthRepository;
  final Dio _dioClient;

  AuthInterceptor(this._tokenStorage, this._oauthRepository, this._dioClient);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      await _addAuthorizationHeader(options);
    } catch (_) {}
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final response = await _retryWithNewToken(err);
        return handler.resolve(response);
      } catch (_) {
        await _tokenStorage.clear();
        navigatorKey.currentState?.pushNamedAndRemoveUntil('/auth', (route) => false);
      }
    }
    handler.next(err);
  }

  Future<void> _addAuthorizationHeader(RequestOptions options) async {
    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  bool _shouldRetry(DioException err) =>
      err.response?.statusCode == 401 && err.requestOptions.extra['retried'] != true;

  Future<Response> _retryWithNewToken(DioException err) async {
    await _oauthRepository.refreshToken();
    final newToken = await _tokenStorage.getAccessToken();

    if (newToken == null) throw Exception('Unable to refresh token');
    final opts = err.requestOptions;

    opts.headers['Authorization'] = 'Bearer $newToken';
    opts.extra['retried'] = true;

    return _dioClient.fetch(opts);
  }
}
