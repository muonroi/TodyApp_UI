import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:tudy/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:tudy/features/auth/domain/usecases/login_usecase.dart';
import 'package:tudy/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tudy/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:tudy/features/auth/domain/usecases/social_login_usecase.dart';
part 'auth_state.dart';
part '../auth_register/auth_register_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SocialLoginUseCase
      _socialLoginUseCase; // ✨ Add the new use case dependency ✨

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCachedUserUseCase getCachedUserUseCase,
    required SocialLoginUseCase socialLoginUseCase,
  })  : _loginUseCase = loginUseCase,
        _refreshTokenUseCase = refreshTokenUseCase,
        _logoutUseCase = logoutUseCase,
        _getCachedUserUseCase = getCachedUserUseCase,
        _socialLoginUseCase = socialLoginUseCase, // ✨ Assign the new use case ✨

        super(AuthInitial()) {
    //checkInitialAuthStatus();
  }

  Future<void> checkInitialAuthStatus() async {
    try {
      final user = await _getCachedUserUseCase.execute();
      if (user != null) {
        state = AuthAuthenticated(user: user);
      } else {
        state = AuthUnauthenticated();
      }
    } catch (e) {
      state = AuthUnauthenticated();
    }
  }

  Future<void> login(String username, String password) async {
    state = AuthLoading();
    try {
      final isLoginSuccess = await _loginUseCase.execute(username, password);
      if (isLoginSuccess) {
        final user = await _getCachedUserUseCase.execute();
        if (user != null) {
          state = AuthAuthenticated(user: user);
        } else {
          state = const AuthError(
              message: "Login successful but couldn't retrieve user data.");
        }
      } else {
        state = AuthUnauthenticated();
      }
    } catch (e) {
      state = AuthUnauthenticated();
    }
  }

  Future<void> loginWithSocial(SocialLoginParams params) async {
    state = AuthLoading();
    try {
      final isLoginSuccess = await _socialLoginUseCase.execute(params);
      if (isLoginSuccess) {
        final user = await _getCachedUserUseCase.execute();
        if (user != null) {
          state = AuthAuthenticated(user: user);
        } else {
          state = const AuthError(
              message:
                  "Social login successful but couldn't retrieve user data.");
        }
      } else {
        state = const AuthError(message: "Social login failed.");
      }
    } catch (e) {
      state = AuthError(message: "Social login failed: ${e.toString()}");
    }
  }

  Future<void> refreshToken(String accessToken, String refreshToken) async {
    try {
      final isRefreshSuccess =
          await _refreshTokenUseCase.execute(accessToken, refreshToken);
      if (isRefreshSuccess) {
        final user = await _getCachedUserUseCase.execute();
        if (user != null) {
          if (state is AuthAuthenticated) {
            state = AuthAuthenticated(user: user);
          }
        } else {
          state = AuthUnauthenticated();
        }
      } else {
        state = AuthUnauthenticated();
      }
    } catch (e) {
      state = AuthUnauthenticated();
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUseCase.execute();

      state = AuthUnauthenticated();
    } catch (e) {
      state = AuthUnauthenticated();
    }
  }
}
