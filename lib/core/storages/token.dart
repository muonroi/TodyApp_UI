class TokenStorage {
  String? _accessToken;
  String? _refreshToken;

  String? getAccessToken() {
    if (_accessToken != null && _accessToken!.isNotEmpty) {
      return _accessToken;
    }
    return null;
  }

  void setAccessToken(String token) => _accessToken = token;

  String? getRefreshToken() => _refreshToken;
  void setRefreshToken(String token) => _refreshToken = token;
}
