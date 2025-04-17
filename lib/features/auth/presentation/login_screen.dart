import 'package:flutter/material.dart';
import 'package:tudy/features/auth/presentation/pages/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
