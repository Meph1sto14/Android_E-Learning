import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  /// === App Bar ===
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
        _buildLoginMenu(context),
        const SizedBox(width: 8),
        _buildRegisterButton(context),
        const SizedBox(width: 16),
      ],
    );
  }

  /// === Popup Login Menu ===
  Widget _buildLoginMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (role) {
        Navigator.pushNamed(context, '/login', arguments: role);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'siswa', child: Text('Siswa')),
        PopupMenuItem(value: 'guru', child: Text('Guru')),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// === Register Button ===
  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
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
    );
  }

  /// === Body ===
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _buildTitle(),
          const SizedBox(height: 20),
          _buildDescription(),
          const SizedBox(height: 50),
          _buildIllustration(),
        ],
      ),
    );
  }

  /// === Title ===
  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          height: 1.3,
          fontFamily: 'Poppins',
        ),
        children: [
          TextSpan(
            text: 'Learning\n',
            style: TextStyle(color: Colors.orange),
          ),
          TextSpan(text: 'Management\nSystem (LMS)'),
        ],
      ),
    );
  }

  /// === Description ===
  Widget _buildDescription() {
    return const Text(
      'Perangkat lunak berbasis web yang digunakan untuk mengelola pembelajaran secara online.\n'
      'Web-based software used to manage online learning.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black54,
        height: 1.5,
      ),
    );
  }

  /// === Illustration Icon ===
  Widget _buildIllustration() {
    return const Center(
      child: Icon(
        Icons.school,
        size: 250,
        color: Color.fromARGB(204, 0, 150, 136),
      ),
    );
  }
}
