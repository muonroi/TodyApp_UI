import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> login(String username, String password);
  Future<bool> register(String username, String password, String emailAddress,
      String name, String surname, String phoneNumber);
  Future<User?> getUser();
  Future<void> logout();
  Future<bool> refreshToken(String accessToken, String refreshToken);
}
