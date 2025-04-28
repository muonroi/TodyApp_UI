// Hypothetical SocialLoginUseCase
// File: lib/features/auth/domain/usecases/social_login_usecase.dart
import 'package:tudy/features/auth/domain/repositories/auth_repository.dart'; // Assuming AuthRepository

class SocialLoginParams {
  final String provider;
  final String token;
  final String? email;
  final String? name;
  final String? surname;
  // Add other relevant social data like photoUrl if your API supports it

  SocialLoginParams({
    required this.provider,
    required this.token,
    this.email,
    this.name,
    this.surname,
  });
}

class SocialLoginUseCase {
  final AuthRepository authRepository;

  SocialLoginUseCase(this.authRepository);

  Future<bool> execute(SocialLoginParams params) async {
    String username = params.email ??
        params.name ??
        '${params.provider.toLowerCase()}_user_${params.token.substring(0, 8)}';
    String password =
        'DUMMY_PASSWORD_FOR_SOCIAL_${DateTime.now().microsecondsSinceEpoch}';
    String name = params.name ?? 'User';
    String surname = params.surname ?? 'User';
    bool isUseThirdPartyLogin = true;
    String externalLoginProvider = params.provider;
    String externalLoginToken = params.token;
    String email = params.email ??
        '${params.provider.toLowerCase()}_user_${params.token.substring(0, 8)}@example.com';

    final success = await authRepository.register(
        username,
        password,
        email,
        name,
        surname,
        "",
        externalLoginProvider,
        externalLoginToken,
        isUseThirdPartyLogin);
    return success;
  }
}
