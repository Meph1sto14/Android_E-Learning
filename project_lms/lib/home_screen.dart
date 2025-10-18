import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SMPN 3 Purwokerto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Register'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: 'Learning\n',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: 'Management\nSystem (LMS)',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Perangkat lunak berbasis web yang digunakan untuk mengelola pembelajaran secara online.\nWeb-based software used to manage online learning.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Icon(
                  Icons.school,
                  size: 250,
                  color: Colors.teal.withOpacity(0.8),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}