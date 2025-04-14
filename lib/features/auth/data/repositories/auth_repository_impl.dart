import 'package:tudy/features/auth/data/models/login_model.dart';
import 'package:tudy/features/auth/data/models/refresh_token_model.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<bool> login(String username, String password) async {
    final userModel = await remoteDataSource.login(LoginModel(
      username: username,
      password: password,
    ));
    if (userModel == null) {
      return false;
    }
    await localDataSource.cacheUser(userModel);
    return true;
  }

  @override
  Future<User?> getUser() async {
    return await localDataSource.getCachedUser();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }

  @override
  Future<bool> refreshToken(String accessToken, String refreshToken) async {
    final response = await remoteDataSource.refreshToken(RefreshTokenModel(
        refreshToken: refreshToken, accessToken: accessToken));
    if (response['result'] != null) {
      final updatedUserModel = UserModel.fromJson(response['result']);
      await localDataSource.cacheUser(updatedUserModel);
      return true;
    }
    return false;
  }
}
