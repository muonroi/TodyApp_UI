import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/features/auth/presentation/login_screen.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';

import 'package:tudy/features/auth/presentation/providers/auth_login/auth_providers.dart';
import 'package:tudy/features/auth/presentation/providers/auth_register/auth_register_providers.dart';

import 'package:tudy/features/home/presentation/home_screen.dart';
import 'package:tudy/features/auth/presentation/register_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const unauthenticatedRoutes = [login, register];
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ValueNotifier<int>(0);

  ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    refreshNotifier.value++;
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: refreshNotifier,
    initialLocation: RouteName.login,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authNotifierProvider);
      final authRegisterState = ref.read(authRegisterNotifierProvider);
      final isAuthenticated = authState is AuthAuthenticated;
      final isRegisterSuccess = authRegisterState is AuthRegisterSuccess;

      final isAllowedAccess = isAuthenticated || isRegisterSuccess;

      final requestedPath = state.fullPath ?? '';
      final isGoingToUnauthenticatedRoute =
          RouteName.unauthenticatedRoutes.contains(requestedPath);

      if (!isAllowedAccess && !isGoingToUnauthenticatedRoute) {
        return RouteName.login;
      } else if (isAllowedAccess && isGoingToUnauthenticatedRoute) {
        return RouteName.home;
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(
        path: RouteName.home,
        pageBuilder: (context, state) =>
            const MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: RouteName.login,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
      ),
      GoRoute(
        path: RouteName.register,
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreen()),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});
