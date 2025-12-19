import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- Import Controller ---
import 'package:project_lms/features/siswa/dashboard/controllers/dashboard_siswa_controller.dart';
import 'package:project_lms/features/siswa/jadwal/controllers/jadwal_controller.dart';

// --- Import Halaman Bersama ---
import 'package:project_lms/features/home/home_screen.dart';
import 'package:project_lms/features/auth/login_screen.dart';
import 'package:project_lms/features/auth/register_screen.dart';

// --- Import Halaman Guru ---
import 'package:project_lms/features/guru/dashboard_guru_screen.dart';

// --- Import Halaman Siswa ---
import 'package:project_lms/features/siswa/dashboard/screens/dashboard_siswa_screen.dart';
import 'package:project_lms/features/siswa/tugas/screens/tugas_list_screen.dart';
import 'package:project_lms/features/siswa/tugas/screens/kirim_tugas_screen.dart';
import 'package:project_lms/features/siswa/nilai/screens/nilai_screen.dart';
import 'package:project_lms/features/siswa/materi/screens/materi_detail_screen.dart';
import 'package:project_lms/features/siswa/jadwal/screens/jadwal_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardSiswaController(),
        ),
        ChangeNotifierProvider(
          create: (_) => JadwalController(), // ✅ WAJIB
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Poppins',
      ),
      routes: {
        // --- Rute Bersama ---
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),

        // --- Rute Guru ---
        '/dashboard_guru': (context) => const DashboardGuruScreen(),

        // --- Rute Siswa ---
        '/dashboard_siswa': (context) => const DashboardSiswaScreen(),
        '/jadwal': (context) => const JadwalScreen(), // ✅ TAMBAHAN
        '/tugas': (context) => const TugasListScreen(),
        '/nilai': (context) => const NilaiScreen(),

        // --- Kirim Tugas ---
        '/kirim_tugas': (context) {
          final dynamic argsRaw =
              ModalRoute.of(context)!.settings.arguments;

          if (argsRaw == null || argsRaw is! Map<String, String>) {
            return const KirimTugasScreen(
              mapel: 'Error',
              judul: 'Halaman tidak valid',
            );
          }

          return KirimTugasScreen(
            mapel: argsRaw['mapel'] ?? 'Error',
            judul: argsRaw['judul'] ?? 'Error',
          );
        },

        // --- Detail Materi ---
        '/materi_detail': (context) {
          final dynamic titleRaw =
              ModalRoute.of(context)!.settings.arguments;

          if (titleRaw == null || titleRaw is! String) {
            return const MateriDetailScreen(
              title: 'Materi tidak ditemukan',
            );
          }

          return MateriDetailScreen(title: titleRaw);
        },
      },
    );
  }
}
