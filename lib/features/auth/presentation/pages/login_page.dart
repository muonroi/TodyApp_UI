import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/config/router.dart';
import 'package:tudy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:tudy/l10n/app_localizations.dart';

import '../providers/auth_providers.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      final messenger = ScaffoldMessenger.of(context);
      if (next is AuthAuthenticated) {
        messenger.removeCurrentSnackBar();
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.loginSuccessMessage),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ));
        context.go(RouteName.home);
      } else if (next is AuthError) {
        messenger.removeCurrentSnackBar();
        messenger.showSnackBar(SnackBar(
          content: Text("Login Failed: ${next.message}"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
