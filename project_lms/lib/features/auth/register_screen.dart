import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRole;
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  final List<String> _roles = ['Siswa', 'Guru'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(28.0),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.teal.shade600,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🧩 Judul
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // 🧩 Subjudul
                const Text(
                  'Daftarkan diri Anda untuk mengakses sistem LMS SMPN 3 Purwokerto.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 32),

                // 🧩 Field Nama Lengkap
                _buildTextField(
                  hint: 'Nama Lengkap',
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(height: 16),

                // 🧩 Dropdown Role (Siswa/Guru)
                _buildRoleDropdown(),
                const SizedBox(height: 16),

                // 🧩 Field NISN / NIP
                _buildTextField(
                  hint: _selectedRole == 'Guru' ? 'NIP' : 'NISN',
                  icon: Icons.numbers,
                ),
                const SizedBox(height: 16),

                // 🧩 Field Email
                _buildTextField(
                  hint: 'Email',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // 🧩 Field Password
                _buildPasswordField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  isObscured: _isPasswordObscured,
                  onToggle: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // 🧩 Field Konfirmasi Password
                _buildPasswordField(
                  hint: 'Konfirmasi Password',
                  icon: Icons.lock_reset_outlined,
                  isObscured: _isConfirmPasswordObscured,
                  onToggle: () {
                    setState(() {
                      _isConfirmPasswordObscured =
                          !_isConfirmPasswordObscured;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // 🧩 Tombol Daftar
                _buildRegisterButton(),
                const SizedBox(height: 20),

                // 🧩 Link ke Login
                _buildLoginLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧱 TextField Umum
  Widget _buildTextField({required String hint, required IconData icon}) {
    return TextField(
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
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  // 🧱 Field Password (dengan toggle visibility)
  Widget _buildPasswordField({
    required String hint,
    required IconData icon,
    required bool isObscured,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.teal.shade800),
        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.teal.shade800,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  // 🧱 Dropdown Role (Siswa / Guru)
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      hint: Text(
        'Pilih Role (Siswa / Guru)',
        style: TextStyle(color: Colors.grey.shade600),
      ),
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_pin_outlined,
          color: Colors.teal.shade800,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      icon: Icon(Icons.arrow_drop_down, color: Colors.teal.shade800),
      items: _roles
          .map((String role) => DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              ))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue;
        });
      },
    );
  }

  // 🧱 Tombol Register
  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implementasi logika registrasi
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registrasi Berhasil!'),
            ),
          );
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
          'Daftar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 🧱 Link ke Login
  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(
            color: Color.fromARGB(230, 255, 255, 255),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            'Login di sini',
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
