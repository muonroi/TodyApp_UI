part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}

class RefreshTokenRequested extends AuthEvent {
  final String accessToken;
  final String refreshToken;

  RefreshTokenRequested({
    required this.accessToken,
    required this.refreshToken,
  });
}

class LogoutRequested extends AuthEvent {}
