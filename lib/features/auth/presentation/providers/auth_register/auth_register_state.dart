part of '../auth_login/auth_notifier.dart';

abstract class AuthRegisterState extends Equatable {
  const AuthRegisterState();

  @override
  List<Object?> get props => [];
}

class AuthRegisterInitial extends AuthRegisterState {}

class AuthRegisterLoading extends AuthRegisterState {}

class AuthRegisterSuccess extends AuthRegisterState {
  final bool isSuccess;

  const AuthRegisterSuccess({required this.isSuccess});

  @override
  List<Object?> get props => [isSuccess];
}

class AuthUnRegister extends AuthRegisterState {}

class AuthRegisterError extends AuthRegisterState {
  final String message;

  const AuthRegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
