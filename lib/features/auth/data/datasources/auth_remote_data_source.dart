import 'package:tudy/core/base_service.dart';
import 'package:tudy/features/auth/data/models/login_model.dart';
import 'package:tudy/features/auth/data/models/refresh_token_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> login(LoginModel loginModel);
  Future<Map<String, dynamic>> refreshToken(
      RefreshTokenModel refreshTokenModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseService baseService;

  AuthRemoteDataSourceImpl({required this.baseService});

  @override
  Future<UserModel?> login(LoginModel loginModel) async {
    final response = await baseService.postData<UserModel>(
        '/auth/login',
        {
          'username': loginModel.username,
          'password': loginModel.password,
        },
        fromJson: (json) => UserModel.fromJson(json));
    if (response == null) {
      return null;
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>> refreshToken(
      RefreshTokenModel refreshTokenModel) async {
    final response = await baseService.postData<Map<String, dynamic>>(
      '/refresh-token',
      {
        'accessToken': refreshTokenModel.accessToken,
        'refreshToken': refreshTokenModel.refreshToken
      },
      fromJson: (json) => json as Map<String, dynamic>,
    );
    return response!;
  }
}
