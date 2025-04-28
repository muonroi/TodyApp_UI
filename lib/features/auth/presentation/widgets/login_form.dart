import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:tudy/config/app_assets.dart';
import 'package:tudy/config/router.dart';
import 'package:tudy/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_notifier.dart';
import 'package:tudy/features/auth/presentation/providers/auth_login/auth_providers.dart';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<void> _handleGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      debugPrint('Google Sign-In cancelled');
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    debugPrint(
        'Google User: ${googleUser.email}, ID Token: ${googleAuth.idToken}');

    ref.read(authNotifierProvider.notifier).loginWithSocial(SocialLoginParams(
          provider: 'Google',
          token: googleAuth.idToken!,
          email: googleUser.email,
          name: googleUser.displayName,
        ));
  }

  Future<void> _handleAppleSignIn() async {
    final isAvailable = await SignInWithApple.isAvailable();
    if (!isAvailable && mounted) {
      debugPrint('Apple Sign-In is not available on this device');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context).appleSignInNotAvailable)),
      );
      return;
    }

    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    debugPrint('Apple User ID: ${appleCredential.userIdentifier}');
    debugPrint('Apple Email: ${appleCredential.email}');
    debugPrint('Apple Given Name: ${appleCredential.givenName}');
    debugPrint('Apple Family Name: ${appleCredential.familyName}');
    debugPrint('Apple Identity Token: ${appleCredential.identityToken}');
    debugPrint(
        'Apple Authorization Code: ${appleCredential.authorizationCode}');

    ref.read(authNotifierProvider.notifier).loginWithSocial(SocialLoginParams(
          provider: 'Apple',
          token: appleCredential.identityToken ??
              appleCredential.authorizationCode,
          email: appleCredential.email,
          name: appleCredential.givenName,
          surname: appleCredential.familyName,
        ));
  }

  void _navigateToRegister() {
    context.go(RouteName.register);
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
    required Future<void> Function()? onPressed,
    required String logoAsset,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    required ThemeData theme,
    bool? isAppleSignIn,
  }) {
    Color btnBackgroundColor = backgroundColor;
    Color btnForegroundColor = foregroundColor;
    SvgPicture logo = SvgPicture.asset(logoAsset, height: 20.0);

    if (isAppleSignIn == true) {
      if (theme.brightness == Brightness.dark) {
        btnBackgroundColor = Colors.white;
        btnForegroundColor = Colors.black;
        logo = SvgPicture.asset(logoAsset,
            height: 20.0,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn));
      } else {
        btnBackgroundColor = Colors.black;
        btnForegroundColor = Colors.white;
        logo = SvgPicture.asset(logoAsset,
            height: 20.0,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn));
      }
    }

    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: logo,
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        style: theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(btnBackgroundColor),
            foregroundColor: WidgetStateProperty.all(btnForegroundColor),
            padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 12.0)),
            elevation: WidgetStateProperty.all(1),
            side: WidgetStateProperty.all(BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.5))),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ))),
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

    ref.listen<AuthState>(authNotifierProvider, (previous, current) {
      if (current is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(current.message)),
        );
      }

      if (current is AuthAuthenticated) {}
    });

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
              enabled: !isLoading,
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
              enabled: !isLoading,
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
                  onPressed: isLoading ? null : _handleGoogleSignIn,
                  logoAsset: ImageAssets.googleLogo,
                  label: l10n.googleLogin,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  theme: theme,
                ),
                if (platform == TargetPlatform.iOS ||
                    platform == TargetPlatform.macOS) ...[
                  const SizedBox(width: 16.0),
                  _buildSocialButton(
                    onPressed: isLoading ? null : _handleAppleSignIn,
                    logoAsset: ImageAssets.appleLogo,
                    label: l10n.appleLogin,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    theme: theme,
                    isAppleSignIn: true,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 32.0),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textTheme.bodyMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.8)),
                  children: <TextSpan>[
                    TextSpan(text: "${l10n.noAccount} "),
                    TextSpan(
                      text: l10n.register,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = isLoading ? null : _navigateToRegister,
                    ),
                  ],
                ),
              ),
            ),
            if (authState is AuthError)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  authState.message,
                  style:
                      textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
