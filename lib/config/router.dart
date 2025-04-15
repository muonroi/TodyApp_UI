import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/features/auth/presentation/providers/auth_notifier.dart';

import 'package:tudy/features/auth/presentation/providers/auth_providers.dart';

import 'package:tudy/features/home/presentation/home.dart';
import 'package:tudy/features/auth/presentation/pages/login_page.dart';
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
      final isAuthenticated = authState is AuthAuthenticated;

      final requestedPath = state.fullPath ?? '';
      final isGoingToUnauthenticatedRoute =
          RouteName.unauthenticatedRoutes.contains(requestedPath);

      if (!isAuthenticated && !isGoingToUnauthenticatedRoute) {
        return RouteName.login;
      } else if (isAuthenticated && isGoingToUnauthenticatedRoute) {
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
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
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
