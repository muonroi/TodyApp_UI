import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<User?> getUser();
  Future<void> logout();
  Future<bool> refreshToken(String accessToken, String refreshToken);
}
