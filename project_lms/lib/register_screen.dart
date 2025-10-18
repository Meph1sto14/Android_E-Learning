import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text(
          'Ini adalah Halaman Registrasi',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}