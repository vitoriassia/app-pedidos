/// Payload for obtaining OAuth token via refresh_token grant.
class GetRefreshTokenPayload {
  final String grantType;
  final String refreshToken;

  GetRefreshTokenPayload({required this.refreshToken}) : grantType = 'refresh_token';

  /// Creates a payload from JSON.
  factory GetRefreshTokenPayload.fromJson(Map<String, dynamic> json) {
    return GetRefreshTokenPayload(refreshToken: json['refresh_token'] as String);
  }

  /// Converts the payload to JSON.
  Map<String, dynamic> toJson() {
    return {'grant_type': grantType, 'refresh_token': refreshToken};
  }
}
