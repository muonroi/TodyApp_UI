import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<bool> execute(String accessToken, String refreshToken) {
    return repository.refreshToken(accessToken, refreshToken);
  }
}
