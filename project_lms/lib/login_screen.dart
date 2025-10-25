import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? roleArgument =
        ModalRoute.of(context)!.settings.arguments as String?;

    final String role = roleArgument ?? 'Tamu';

    final String displayRole = role[0].toUpperCase() + role.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login - $displayRole'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Ini adalah Halaman Login untuk $displayRole',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
