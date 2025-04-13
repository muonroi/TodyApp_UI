import 'package:bloc/bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.refreshTokenUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase.execute(event.username, event.password);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<RefreshTokenRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await refreshTokenUseCase.execute(
            event.accessToken, event.refreshToken);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await logoutUseCase.execute();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
