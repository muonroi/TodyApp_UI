import 'package:tudy/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> execute(String username, String password, String emailAddress,
      String name, String surname, String phoneNumber) {
    return repository.register(
      username,
      password,
      emailAddress,
      name,
      surname,
      phoneNumber,
      "",
      "",
      false,
    );
  }
}
