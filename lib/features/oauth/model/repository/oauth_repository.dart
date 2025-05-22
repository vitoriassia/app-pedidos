import 'package:pedidos_app/core/state/ui_state.dart';

import '../get_token_payload.dart';

abstract class OAuthRepository {
  Future<UiState> login({required GetTokenPayload payload});

  Future<void> refreshToken();

  Future<void> logout();

  Future<UiState> checkSession();
}
