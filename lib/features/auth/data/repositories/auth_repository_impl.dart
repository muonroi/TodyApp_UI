import 'package:tudy/core/storages/token.dart';
import 'package:tudy/features/auth/data/models/login_model.dart';
import 'package:tudy/features/auth/data/models/refresh_token_model.dart';
import 'package:tudy/features/auth/data/models/register_model.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl({
    required this.tokenStorage,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<bool> login(String username, String password) async {
    final loginResponseModel = await remoteDataSource.login(LoginModel(
      username: username,
      password: password,
    ));
    if (loginResponseModel == null) {
      return false;
    }
    tokenStorage.setAccessToken(loginResponseModel.accessToken);
    tokenStorage.setRefreshToken(loginResponseModel.refreshToken);
    await localDataSource.cacheUser(loginResponseModel);
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
      final updatedUserModel = LoginResponseModel.fromJson(response['result']);
      tokenStorage.setAccessToken(updatedUserModel.accessToken);
      tokenStorage.setRefreshToken(updatedUserModel.refreshToken);
      await localDataSource.cacheUser(updatedUserModel);
      return true;
    }
    return false;
  }

  @override
  Future<bool> register(
      String username,
      String password,
      String emailAddress,
      String name,
      String surname,
      String phoneNumber,
      String externalLoginProvider,
      String externalLoginToken,
      bool isUseThirdPartyLogin) async {
    final loginResponseModel = await remoteDataSource.register(RegisterModel(
      username: username,
      password: password,
      email: emailAddress,
      name: name,
      surname: surname,
      externalLoginProvider: externalLoginProvider,
      externalLoginToken: externalLoginToken,
      isUseThirdPartyLogin: isUseThirdPartyLogin,
      phoneNumber: phoneNumber,
    ));
    if (loginResponseModel == null) {
      return false;
    }
    tokenStorage.setAccessToken(loginResponseModel.accessToken);
    tokenStorage.setRefreshToken(loginResponseModel.refreshToken);
    await localDataSource.cacheUser(loginResponseModel);
    return true;
  }
}
