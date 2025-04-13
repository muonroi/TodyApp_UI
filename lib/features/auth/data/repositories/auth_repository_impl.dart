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
  Future<User> login(String username, String password) async {
    final userModel = await remoteDataSource.login(username, password);
    await localDataSource.cacheUser(userModel);
    return userModel;
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
  Future<User> refreshToken(String accessToken, String refreshToken) async {
    final response =
        await remoteDataSource.refreshToken(accessToken, refreshToken);
    if (response['result'] != null) {
      final updatedUserModel = UserModel.fromJson(response['result']);
      await localDataSource.cacheUser(updatedUserModel);
      return updatedUserModel;
    }
    throw Exception("Refresh token failed");
  }
}
