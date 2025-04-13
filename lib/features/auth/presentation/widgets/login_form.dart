import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: "Username"),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final username = usernameController.text;
            final password = passwordController.text;
            BlocProvider.of<AuthBloc>(context).add(
              LoginRequested(username: username, password: password),
            );
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
