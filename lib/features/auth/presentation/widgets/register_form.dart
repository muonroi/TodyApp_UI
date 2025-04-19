import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tudy/config/router.dart';

import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';
import 'package:tudy/features/auth/presentation/providers/auth_register/auth_register_providers.dart';
import 'package:tudy/l10n/app_localizations.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  static const int _minUsernameLength = 3;
  static const int _maxUsernameLength = 20;
  static const int _minPasswordLength = 8;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _submitRegister() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;
      final email = _emailController.text.trim();
      final phoneNumber = _phoneController.text.trim();
      final fullName = _fullNameController.text.trim();

      String name = '';
      String surname = '';
      final nameParts = fullName.split(' ');
      if (nameParts.isNotEmpty) {
        surname = nameParts.first;
        if (nameParts.length > 1) {
          name = nameParts.sublist(1).join(' ');
        } else {
          name = surname;
        }
      }

      ref.read(authRegisterNotifierProvider.notifier).register(
            username,
            password,
            email,
            name,
            surname,
            phoneNumber,
          );
    }
  }

  void _navigateToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RouteName.login);
    }
  }

  String? _validateUsername(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.usernameValidationError;
    }
    final trimmedValue = value.trim();
    if (trimmedValue.length < _minUsernameLength ||
        trimmedValue.length > _maxUsernameLength) {
      return l10n.usernameValidationErrorLength;
    }

    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(trimmedValue)) {
      return l10n.usernameValidationErrorChars;
    }
    return null;
  }

  String? _validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.emailValidationErrorEmpty;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n.emailValidationErrorInvalid;
    }
    return null;
  }

  String? _validatePhone(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.phoneValidationErrorEmpty;
    }

    final phoneRegex = RegExp(r'^[0-9]{10,}$');

    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (!phoneRegex.hasMatch(numericValue)) {
      return l10n.phoneValidationErrorInvalid;
    }
    return null;
  }

  String? _validateFullName(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.fullNameValidationErrorEmpty;
    }

    if (value.trim().split(RegExp(r'\s+')).length < 2) {
      return l10n.fullNameValidationErrorMinWords;
    }

    return null;
  }

  String? _validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.passwordValidationError;
    }

    if (value.length < _minPasswordLength) {
      return l10n.passwordValidationErrorLength;
    }

    final complexityRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

    if (!complexityRegex.hasMatch(value)) {
      return l10n.passwordValidationErrorComplexity;
    }

    return null;
  }

  String? _validateConfirmPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.confirmPasswordValidationErrorEmpty;
    }
    if (value != _passwordController.text) {
      return l10n.passwordsDoNotMatch;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final authState = ref.watch(authRegisterNotifierProvider);

    final isLoading = authState is AuthRegisterLoading;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.register,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: l10n.username,
              hintText: l10n.enterUsernameHint,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => _validateUsername(value, l10n),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: l10n.enterEmailHint,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => _validateEmail(value, l10n),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: l10n.phone,
              hintText: l10n.enterPhoneNumberHint,
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => _validatePhone(value, l10n),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              labelText: l10n.fullName,
              hintText: l10n.enterFullNameHint,
              prefixIcon: const Icon(Icons.badge_outlined),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => _validateFullName(value, l10n),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: l10n.password,
              hintText: l10n.enterPasswordHint,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) => _validatePassword(value, l10n),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: l10n.confirmPassword,
              hintText: l10n.enterConfirmPasswordHint,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
            ),
            textInputAction: TextInputAction.done,
            validator: (value) => _validateConfirmPassword(value, l10n),
            onFieldSubmitted: (_) => isLoading ? null : _submitRegister,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: isLoading ? null : _submitRegister,
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: colorScheme.onPrimary,
                      strokeWidth: 3,
                    ),
                  )
                : Text(l10n.registerButton),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                children: <TextSpan>[
                  TextSpan(text: "${l10n.alreadyHaveAccount} "),
                  TextSpan(
                    text: l10n.login,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _navigateToLogin,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
