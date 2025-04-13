import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository repository;

  GetCachedUserUseCase(this.repository);

  Future<User?> execute() {
    return repository.getUser();
  }
}
