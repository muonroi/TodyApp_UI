import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/config/router.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';
import 'package:tudy/features/auth/presentation/providers/auth_register/auth_register_providers.dart';
import 'package:tudy/features/auth/presentation/widgets/register_form.dart';
import 'package:tudy/l10n/app_localizations.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    ref.listen<AuthRegisterState>(authRegisterNotifierProvider,
        (previous, next) {
      final messenger = ScaffoldMessenger.of(context);
      if (next is AuthRegisterSuccess) {
        messenger.removeCurrentSnackBar();
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.registrationSuccessMessage),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ));
        context.go(RouteName.home);
      } else if (next is AuthError) {
        messenger.removeCurrentSnackBar();
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.registrationFailedMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: context.canPop()
            ? BackButton(color: Theme.of(context).colorScheme.onSurface)
            : null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
