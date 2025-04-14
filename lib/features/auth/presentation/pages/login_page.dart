import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/config/router.dart';
import 'package:tudy/features/auth/presentation/providers/auth_notifier.dart';

import '../providers/auth_providers.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login successful! Welcome back!"),
          backgroundColor: Colors.green,
        ));

        context.go(RouteName.home);
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login Failed: ${next.message}"),
          backgroundColor: Colors.red,
        ));
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Builder(
        builder: (context) {
          if (authState is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          );
        },
      ),
    );
  }
}
