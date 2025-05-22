import 'package:dio/dio.dart';
import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/core/state/repository_handler.dart';
import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/core/storage/token_storage.dart';
import 'package:pedidos_app/features/oauth/model/get_token_payload.dart';
import '../get_refresh_token_payload.dart';
import 'oauth_repository.dart';

class OAuthRepositoryImpl implements OAuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _storage;

  OAuthRepositoryImpl(this._apiClient, this._storage);

  @override
  Future<UiState> login({required GetTokenPayload payload}) async {
    return repositoryHandler(() async {
      final response = await _apiClient.post(
        '/connect/token',
        body: payload.toJson(),
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final data = response.data as Map<String, dynamic>;

      await _storage.saveAccessToken(data['access_token'] as String);
      await _storage.saveRefreshToken(data['refresh_token'] as String);
    });
  }

  @override
  Future<UiState> refreshToken() async {
    return repositoryHandler(() async {
      final refresh = await _storage.getRefreshToken();

      if (refresh == null) {
        throw Exception('No refresh token available');
      }
      final payload = GetRefreshTokenPayload(refreshToken: refresh);

      final response = await _apiClient.post('/oauth/token', body: payload.toJson());

      final data = response.data as Map<String, dynamic>;
      await _storage.saveAccessToken(data['access_token'] as String);
      await _storage.saveRefreshToken(data['refresh_token'] as String);
    });
  }

  @override
  Future<void> logout() async {
    await _storage.clear();
  }

  @override
  Future<UiState> checkSession() async {
    final token = await _storage.getAccessToken();

    return SuccessState(token != null);
  }
}
