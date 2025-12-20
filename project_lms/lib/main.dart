import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ Pastikan sudah install package ini

// --- Import Config ---
import 'package:project_lms/shared/config/supabase_config.dart'; // ✅ Pastikan file ini sudah dibuat

// --- Import Controllers ---
import 'package:project_lms/features/siswa/dashboard/controllers/dashboard_siswa_controller.dart';
import 'package:project_lms/features/siswa/jadwal/controllers/jadwal_controller.dart';
import 'package:project_lms/features/guru/controllers/guru_controller.dart';

// --- Import Screens ---
import 'package:project_lms/features/home/home_screen.dart';
import 'package:project_lms/features/auth/login_screen.dart';
import 'package:project_lms/features/auth/register_screen.dart';
import 'package:project_lms/features/guru/screens/dashboard_guru_screen.dart';
import 'package:project_lms/features/siswa/dashboard/screens/dashboard_siswa_screen.dart';
import 'package:project_lms/features/siswa/jadwal/screens/jadwal_screen.dart';
import 'package:project_lms/features/siswa/tugas/screens/tugas_list_screen.dart';
import 'package:project_lms/features/siswa/tugas/screens/kirim_tugas_screen.dart';
import 'package:project_lms/features/siswa/nilai/screens/nilai_screen.dart';
import 'package:project_lms/features/siswa/materi/screens/materi_detail_screen.dart';

Future<void> main() async {
  // 1. Wajib panggil ini karena main sekarang bersifat async
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi Supabase
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardSiswaController()),
        ChangeNotifierProvider(create: (_) => JadwalController()),
        ChangeNotifierProvider(create: (_) => GuruController()),
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
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),

        // --- Rute Guru ---
        '/dashboard_guru': (context) => const DashboardGuruScreen(),

        // --- Rute Siswa ---
        '/dashboard_siswa': (context) => const DashboardSiswaScreen(),
        '/jadwal': (context) => const JadwalScreen(),
        '/tugas': (context) => const TugasListScreen(),
        '/nilai': (context) => const NilaiScreen(),

        // --- Rute Dynamic (Kirim Tugas) ---
        '/kirim_tugas': (context) {
          final dynamic argsRaw = ModalRoute.of(context)!.settings.arguments;
          if (argsRaw == null || argsRaw is! Map<String, String>) {
            return const KirimTugasScreen(mapel: 'Error', judul: 'Halaman tidak valid');
          }
          return KirimTugasScreen(
            mapel: argsRaw['mapel'] ?? 'Error',
            judul: argsRaw['judul'] ?? 'Error',
          );
        },

        // --- Rute Dynamic (Detail Materi) ---
        '/materi_detail': (context) {
          final dynamic titleRaw = ModalRoute.of(context)!.settings.arguments;
          if (titleRaw == null || titleRaw is! String) {
            return const MateriDetailScreen(title: 'Materi tidak ditemukan');
          }
          return MateriDetailScreen(title: titleRaw);
        },
      },
    );
  }
}