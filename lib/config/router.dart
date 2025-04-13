import 'package:go_router/go_router.dart';
import 'package:tudy/features/home/presentation/home.dart';
import 'package:tudy/features/auth/presentation/login_screen.dart';
import 'package:tudy/features/auth/presentation/register_screen.dart';

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static const unAuthorized = [login, register];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.unAuthorized.contains(state.fullPath)) {
      return null;
    }
    return RouteName.login;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
