/// Payload for obtaining OAuth token.
///
/// Supports both 'password' and 'refresh_token' grant types.
class GetTokenPayload {
  /// Grant type: 'password' or 'refresh_token'.
  final String grantType;

  /// Client identifier, default is 'user'.
  final String clientId;

  /// Space-separated scopes, e.g., 'user offline_access'.
  final String? scope;

  /// Username for 'password' grant.
  final String? username;

  /// Password for 'password' grant.
  final String? password;

  /// Refresh token for 'refresh_token' grant.
  final String? refreshToken;

  GetTokenPayload._({
    required this.grantType,
    required this.clientId,
    this.scope,
    this.username,
    this.password,
    this.refreshToken,
  });

  /// Creates payload for password grant.
  factory GetTokenPayload.password({
    required String username,
    required String password,
    String clientId = 'user',
    String? scope,
  }) {
    return GetTokenPayload._(
      grantType: 'password',
      clientId: clientId,
      scope: scope,
      username: username,
      password: password,
      refreshToken: null,
    );
  }

  /// Creates payload for refresh_token grant.
  factory GetTokenPayload.refresh({
    required String refreshToken,
    String clientId = 'user',
    String? scope,
  }) {
    return GetTokenPayload._(
      grantType: 'refresh_token',
      clientId: clientId,
      scope: scope,
      username: null,
      password: null,
      refreshToken: refreshToken,
    );
  }

  /// Converts the payload to JSON for the token request.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'grant_type': grantType, 'client_id': clientId};
    if (scope != null) {
      data['scope'] = scope;
    }
    if (grantType == 'password') {
      data['username'] = username;
      data['password'] = password;
    } else if (grantType == 'refresh_token') {
      data['refresh_token'] = refreshToken;
    }
    return data;
  }
}
