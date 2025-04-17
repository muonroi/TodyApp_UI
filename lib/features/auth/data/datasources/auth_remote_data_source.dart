import 'package:tudy/core/base_service.dart';
import 'package:tudy/features/auth/data/models/login_model.dart';
import 'package:tudy/features/auth/data/models/refresh_token_model.dart';
import 'package:tudy/features/auth/data/models/register_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel?> login(LoginModel loginModel);
  Future<LoginResponseModel?> register(RegisterModel registerModel);
  Future<Map<String, dynamic>> refreshToken(
      RefreshTokenModel refreshTokenModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseService baseService;

  AuthRemoteDataSourceImpl({required this.baseService});

  @override
  Future<LoginResponseModel?> login(LoginModel loginModel) async {
    final response = await baseService.postData<LoginResponseModel>(
        '/auth/login',
        {
          'username': loginModel.username,
          'password': loginModel.password,
        },
        fromJson: (json) => LoginResponseModel.fromJson(json));
    if (response == null) {
      return null;
    }
    return response;
  }

  @override
  Future<LoginResponseModel?> register(RegisterModel registerModel) async {
    final response = await baseService.postData<LoginResponseModel>(
        '/auth/system-register', registerModel.toJson(),
        fromJson: (json) => LoginResponseModel.fromJson(json));
    if (response == null) {
      return null;
    }
    return response;
  }

  @override
  Future<Map<String, dynamic>> refreshToken(
      RefreshTokenModel refreshTokenModel) async {
    final response = await baseService.postData<Map<String, dynamic>>(
      '/auth/refresh-token',
      {
        'accessToken': refreshTokenModel.accessToken,
        'refreshToken': refreshTokenModel.refreshToken
      },
      fromJson: (json) => json as Map<String, dynamic>,
    );
    return response!;
  }
}
