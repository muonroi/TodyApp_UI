import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login successful! Welcome ${state.user.name}"),
            ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
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
