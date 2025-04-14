import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/repository_providers.dart';

import '../usecases/get_cached_user_usecase.dart';
import '../usecases/login_usecase.dart';
import '../usecases/logout_usecase.dart';
import '../usecases/refresh_token_usecase.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return LoginUseCase(repository);
}, name: 'LoginUseCase');

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
}, name: 'LogoutUseCase');

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
}, name: 'RefreshTokenUseCase');

final getCachedUserUseCaseProvider = Provider<GetCachedUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCachedUserUseCase(repository);
}, name: 'GetCachedUserUseCase');
