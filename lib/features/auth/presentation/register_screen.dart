import 'package:flutter/material.dart';
import 'package:tudy/features/auth/presentation/pages/register_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}
