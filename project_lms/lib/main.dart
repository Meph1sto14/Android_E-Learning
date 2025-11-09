import 'package:flutter/material.dart';

// --- Import Halaman Bersama (Shared) ---
import 'package:project_lms/features/home/home_screen.dart';
import 'package:project_lms/features/auth/login_screen.dart';
import 'package:project_lms/features/auth/register_screen.dart';

// --- Import Halaman Guru ---
import 'package:project_lms/features/guru/dashboard_guru_screen.dart';

// --- Import Halaman Siswa ---
// (Menggunakan nama file asli Anda)
import 'package:project_lms/features/siswa/dashboard_siswa_screen.dart';
import 'package:project_lms/features/siswa/tugas_list_screen.dart';
import 'package:project_lms/features/siswa/kirim_tugas_screen.dart';
import 'package:project_lms/features/siswa/nilai_screen.dart';
import 'package:project_lms/features/siswa/materi_detail_screen.dart';

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
      
      // --- DAFTAR RUTE APLIKASI ---
      routes: {
        // Rute Bersama
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),

        // Rute Guru
        '/dashboard_guru': (context) => const DashboardGuruScreen(),

        // Rute Siswa
        '/dashboard_siswa': (context) => const DashboardSiswaScreen(), // Class asli Anda
        '/tugas': (context) => const TugasListScreen(), // Class asli Anda
        '/nilai': (context) => const NilaiScreen(),

        // --- PERBAIKAN: Rute dengan Pengecekan Null ---
        
        '/kirim_tugas': (context) {
          // 1. Ambil argumen sebagai 'dynamic' (bisa null)
          final dynamic argsRaw = ModalRoute.of(context)!.settings.arguments;

          // 2. Cek apakah null atau BUKAN Map
          if (argsRaw == null || argsRaw is! Map<String, String>) {
            // Jika ya, berikan nilai default agar tidak crash
            return const KirimTugasScreen(
              mapel: 'Error',
              judul: 'Halaman ini tidak bisa diakses langsung',
            );
          }
          
          // 3. Jika aman, baru gunakan datanya
          final args = argsRaw;
          return KirimTugasScreen(
            mapel: args['mapel'] ?? 'Error',
            judul: args['judul'] ?? 'Error',
          );
        },
        
        '/materi_detail': (context) {
          // 1. Ambil argumen sebagai 'dynamic' (bisa null)
          final dynamic titleRaw = ModalRoute.of(context)!.settings.arguments;

          // 2. Cek apakah null atau BUKAN String
          if (titleRaw == null || titleRaw is! String) {
            // Jika ya, berikan nilai default
            return const MateriDetailScreen(
              title: 'Error: Materi Tidak Ditemukan',
            );
          }
          
          // 3. Jika aman, baru gunakan datanya
          final title = titleRaw;
          return MateriDetailScreen(
            title: title,
          );
        },
      },
    );
  }
}