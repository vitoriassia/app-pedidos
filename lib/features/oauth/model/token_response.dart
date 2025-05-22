/// Model for the response from the OAuth token endpoint.
class TokenResponse {
  final String accessToken;
  final int expiresIn;
  final String tokenType;
  final String refreshToken;
  final String scope;

  TokenResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.scope,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'] as String,
      refreshToken: json['refresh_token'] as String,
      scope: json['scope'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'scope': scope,
    };
  }
}
