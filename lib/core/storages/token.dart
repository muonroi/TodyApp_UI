class TokenStorage {
  String? _accessToken;
  String? _refreshToken;

  String? getAccessToken() => _accessToken;
  void setAccessToken(String token) => _accessToken = token;

  String? getRefreshToken() => _refreshToken;
  void setRefreshToken(String token) => _refreshToken = token;
}
