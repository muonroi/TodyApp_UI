class RefreshTokenModel {
  final String accessToken;
  final String refreshToken;

  RefreshTokenModel({required this.refreshToken, required this.accessToken});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      refreshToken: json['refresh_token'] as String,
      accessToken: json['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
      'access_token': accessToken,
    };
  }
}
