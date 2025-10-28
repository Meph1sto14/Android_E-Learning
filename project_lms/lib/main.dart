import 'package:flutter/material.dart';
import 'package:project_lms/home_screen.dart';
import 'package:project_lms/login_screen.dart';
import 'package:project_lms/register_screen.dart';
import 'package:project_lms/dashboard_siswa_screen.dart';
import 'package:project_lms/tugas_screen.dart';
import 'package:project_lms/kirim_tugas_screen.dart';
import 'package:project_lms/dashboard_guru_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard_siswa': (context) => const DashboardScreen(),
        '/tugas': (context) => const TugasScreen(),
        '/kirim_tugas': (context) => const KirimTugasScreen(
              mapel: 'Matematika',
              judul: 'Contoh Pengumpulan Tugas',
            ),
        '/dashboard_guru': (context) => const DashboardGuruScreen(),
      },
    );
  }
}

