import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/auth/presentation/providers/auth_notifier.dart';
import '../../domain/providers/usecase_providers.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final refreshTokenUseCase = ref.watch(refreshTokenUseCaseProvider);
  final getCachedUserUseCase = ref.watch(getCachedUserUseCaseProvider);

  return AuthNotifier(
    loginUseCase: loginUseCase,
    logoutUseCase: logoutUseCase,
    refreshTokenUseCase: refreshTokenUseCase,
    getCachedUserUseCase: getCachedUserUseCase,
  );
});
