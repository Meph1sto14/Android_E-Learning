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
PopupMenuButton<String>(
          onSelected: (String role) {
            // 1. Fungsi ini akan berjalan saat item menu dipilih
            // 2. Kita navigasi ke /login dan mengirim 'role' (mis: 'siswa') sebagai arguments
            Navigator.pushNamed(context, '/login', arguments: role);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            // Ini adalah daftar item menu Anda
            const PopupMenuItem<String>(
              value: 'siswa', // nilai yang akan dikirim ke onSelected
              child: Text('Siswa'),
            ),
            const PopupMenuItem<String>(
              value: 'guru', // nilai yang akan dikirim ke onSelected
              child: Text('Guru'),
            ),
            const PopupMenuItem<String>(
              value: 'admin', // nilai yang akan dikirim ke onSelected
              child: Text('Admin'),
            ),
          ],
          // 'child' ini adalah widget yang akan terlihat sebagai tombol "Login"
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16, // Samakan dengan font size di AppBar
                fontWeight: FontWeight.w500, // Agar terlihat seperti tombol
              ),
            ),
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