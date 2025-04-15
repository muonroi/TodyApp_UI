import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tudy/config/app_assets.dart';
import 'package:tudy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:tudy/features/auth/presentation/providers/auth_providers.dart';
import 'package:tudy/l10n/app_localizations.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;
      ref.read(authNotifierProvider.notifier).login(username, password);
    }
  }

  void _handleGoogleSignIn() {
    debugPrint('Google Sign-In Pressed');
  }

  void _handleAppleSignIn() {
    debugPrint('Apple Sign-In Pressed');
  }

  void _navigateToRegister() {
    debugPrint('Navigate to Register Screen');
  }

  Widget _buildDivider(AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        Expanded(child: Divider(color: theme.dividerTheme.color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            l10n.orDivider,
            style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
          ),
        ),
        Expanded(child: Divider(color: theme.dividerTheme.color)),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String logoAsset,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    required ThemeData theme,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          logoAsset,
          height: 20.0,
        ),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        style: theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(foregroundColor),
            padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 12.0)),
            elevation: WidgetStateProperty.all(1),
            side: WidgetStateProperty.all(BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.5)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    final platform = theme.platform;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.login,
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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.usernameValidationError;
                }
                return null;
              },
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
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.passwordValidationError;
                }
                return null;
              },
              onFieldSubmitted: (_) => isLoading ? null : _submitLogin(),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: isLoading ? null : _submitLogin,
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                        strokeWidth: 3,
                      ),
                    )
                  : Text(l10n.loginButton),
            ),
            const SizedBox(height: 32.0),
            _buildDivider(l10n, theme),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(
                  onPressed: _handleGoogleSignIn,
                  logoAsset: ImageAssets.googleLogo,
                  label: l10n.googleLogin,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  theme: theme,
                ),
                if (platform == TargetPlatform.iOS) ...[
                  const SizedBox(width: 16.0),
                  _buildSocialButton(
                    onPressed: _handleAppleSignIn,
                    logoAsset: ImageAssets.appleLogo,
                    label: l10n.appleLogin,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    theme: theme,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 32.0),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(text: l10n.noAccount),
                    TextSpan(
                      text: l10n.register,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _navigateToRegister,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
