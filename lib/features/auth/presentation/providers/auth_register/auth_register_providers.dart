import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/auth/domain/providers/usecase_providers.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';
import 'package:tudy/features/auth/presentation/providers/auth_register/auth_register_notifier.dart';

final authRegisterNotifierProvider =
    StateNotifierProvider<AuthRegisterNotifier, AuthRegisterState>((ref) {
  final registerUseCase = ref.watch(registerUseCaseProvider);

  return AuthRegisterNotifier(registerUseCase: registerUseCase);
});
