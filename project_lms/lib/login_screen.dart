import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text(
          'Ini adalah Halaman Login',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}