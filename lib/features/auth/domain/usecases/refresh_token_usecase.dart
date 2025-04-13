import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<User> execute(String accessToken, String refreshToken) {
    return repository.refreshToken(accessToken, refreshToken);
  }
}
