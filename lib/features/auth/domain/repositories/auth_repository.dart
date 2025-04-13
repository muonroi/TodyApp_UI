import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User?> getUser();
  Future<void> logout();
  Future<User> refreshToken(String accessToken, String refreshToken);
}
