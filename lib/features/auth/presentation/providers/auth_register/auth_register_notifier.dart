import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/auth/domain/usecases/register_usecase.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';

class AuthRegisterNotifier extends StateNotifier<AuthRegisterState> {
  final RegisterUseCase _registerUseCase;
  AuthRegisterNotifier({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(AuthRegisterInitial());

  Future<void> register(String username, String password, String emailAddress,
      String name, String surname, String phoneNumber) async {
    state = AuthRegisterLoading();
    try {
      final isRegisterSuccess = await _registerUseCase.execute(
          username, password, emailAddress, name, surname, phoneNumber);
      if (isRegisterSuccess) {
        state = const AuthRegisterSuccess(isSuccess: true);
      } else {
        state = const AuthRegisterError(message: "Registration failed.");
      }
    } catch (e) {
      state = const AuthRegisterError(message: "Registration failed.");
    }
  }
}
