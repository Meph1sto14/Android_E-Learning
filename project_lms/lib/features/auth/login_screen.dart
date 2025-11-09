import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  bool _rememberMe = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? roleArgument =
        ModalRoute.of(context)!.settings.arguments as String?;
    final String role = roleArgument ?? 'Tamu';
    final String displayRole = role[0].toUpperCase() + role.substring(1);

    final String subtitle = "Halaman Login $displayRole SMPN 3 Purwokerto";
    final String usernameHint = (role == 'siswa') ? 'NISN' : 'NIP/Email';

    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade600,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    51,
                    0,
                    0,
                    0,
                  ), // <-- DIGANTI DI SINI
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(
                      230,
                      255,
                      255,
                      255,
                    ), // <-- DIGANTI DI SINI
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Username / Email Input
                _buildTextField(
                  hint: usernameHint,
                  icon: Icons.person_outline,
                  controller: _usernameController,
                ),
                const SizedBox(height: 16),

                // 🔹 Password Input
                _buildPasswordField(),
                const SizedBox(height: 12),

                // 🔹 Checkbox + Lupa Password
                _buildOptionsRow(),
                const SizedBox(height: 24),

                // 🔹 Tombol Login
                _buildLoginButton(context, role),
                const SizedBox(height: 20),

                // 🔹 Link ke Register
                _buildRegisterLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧩 TextField Umum
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.teal.shade800),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  // 🧩 Field Password
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _isPasswordObscured,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(Icons.lock_outline, color: Colors.teal.shade800),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.teal.shade800,
          ),
          onPressed: () {
            setState(() {
              _isPasswordObscured = !_isPasswordObscured;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  // 🧩 Checkbox & Lupa Password
  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              fillColor: WidgetStateProperty.all(Colors.white),
              checkColor: Colors.teal,
              side: const BorderSide(color: Colors.white),
            ),
            const Text(
              'Ingatkan saya',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forgot_password');
          },
          child: const Text(
            'Lupa Password?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // 🧩 Tombol Login
  Widget _buildLoginButton(BuildContext context, String role) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final username = _usernameController.text;
          final password = _passwordController.text;

          bool loginSuccess = false;
          String? targetRoute;

          if (role == 'guru' && username == 'guru123' && password == 'password') {
            loginSuccess = true;
            targetRoute = '/dashboard_guru';
          } else if (role == 'siswa' &&
              username == 'siswa123' &&
              password == 'password') {
            loginSuccess = true;
            targetRoute = '/dashboard_siswa';
          }

          if (loginSuccess && targetRoute != null) {
            Navigator.pushReplacementNamed(context, targetRoute);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Username atau Password Salah'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal.shade700,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 🧩 Link ke Register
  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum punya akun? ',
          style: TextStyle(
            color: const Color.fromARGB(230, 255, 255, 255),
          ), // <-- DIGANTI DI SINI
          style: TextStyle(
            color: Color.fromARGB(230, 255, 255, 255),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
