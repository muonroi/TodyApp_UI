import 'package:tudy/core/base_service.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
  Future<Map<String, dynamic>> refreshToken(
    String accessToken,
    String refreshToken,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseService baseService;

  AuthRemoteDataSourceImpl({required this.baseService});

  @override
  Future<UserModel> login(String username, String password) async {
    final response = await baseService.postData<UserModel>('/login', {
      'username': username,
      'password': password,
    }, fromJson: (json) => UserModel.fromJson(json));
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> refreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    final response = await baseService.postData<Map<String, dynamic>>(
      '/refresh-token',
      {'accessToken': accessToken, 'refreshToken': refreshToken},
      fromJson: (json) => json as Map<String, dynamic>,
    );
    return response.result;
  }
}
