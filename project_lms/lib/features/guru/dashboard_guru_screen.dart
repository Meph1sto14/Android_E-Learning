import 'package:flutter/material.dart';

// 1. Import SEMUA halaman guru yang akan jadi halaman
import 'package:project_lms/features/guru/upload_tugas_screen.dart';
import 'package:project_lms/features/guru/upload_materi_screen.dart';
import 'package:project_lms/features/guru/monitor_siswa_screen.dart';
import 'package:project_lms/features/guru/penilaian_tugas_screen.dart';

class DashboardGuruScreen extends StatefulWidget {
  const DashboardGuruScreen({super.key});

  @override
  State<DashboardGuruScreen> createState() => _DashboardGuruScreenState();
}

class _DashboardGuruScreenState extends State<DashboardGuruScreen> {
  // 0 = Dashboard, 1 = Upload Tugas, 2 = Upload Materi, dst.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Kita tidak lagi menggunakan DefaultTabController
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Latar belakang abu-abu muda
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: _buildHeader(), // Header "Selamat Datang"
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () {
              // Logika Logout: Kembali ke halaman utama
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
          const SizedBox(width: 10),
        ],
        // --- GANTI TABBAR DENGAN MENU WRAP ---
        bottom: PreferredSize(
          // Beri ruang yang cukup untuk 2 baris tombol
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFEEEEEE)),
              ),
            ),
            // 'Wrap' akan otomatis membuat "A A A / A A"
            child: Wrap(
              spacing: 8.0, // Spasi horizontal antar tombol
              runSpacing: 8.0, // Spasi vertikal antar baris
              children: [
                _buildMenuButton(context, 'Dashboard', 0),
                _buildMenuButton(context, 'Upload Tugas', 1),
                _buildMenuButton(context, 'Upload Materi', 2),
                _buildMenuButton(context, 'Monitor Siswa', 3),
                _buildMenuButton(context, 'Penilaian', 4),
              ],
            ),
          ),
        ),
      ),
      // Ganti TabBarView dengan IndexedStack
      // IndexedStack menjaga agar halaman tidak di-refresh saat ganti menu
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          // Halaman 0: Dashboard (konten kartu kelas)
          _DashboardTabContent(),
          
          // Halaman 1: Upload Tugas
          UploadTugasScreen(),
          
          // Halaman 2: Upload Materi
          UploadMateriScreen(),
          
          // Halaman 3: Monitor Siswa
          MonitorSiswaScreen(),
          
          // Halaman 4: Penilaian Tugas
          PenilaianTugasScreen(),
        ],
      ),
    );
  }

  // --- Widget untuk Tombol Menu (Chip) ---
  Widget _buildMenuButton(BuildContext context, String text, int index) {
    final bool isSelected = _selectedIndex == index;

    return FilterChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          // Ganti halaman saat tombol di-klik
          _selectedIndex = index;
        });
      },
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.teal.shade700,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
      selectedColor: Colors.teal, // Warna tombol aktif
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        // Beri border agar mirip desain
        side: BorderSide(
            color: isSelected ? Colors.teal : Colors.grey.shade300),
      ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }

  // --- Widget untuk Header (Sama) ---
  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          'E-Learning SMPN 3 Purwokerto',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Text(
          'Selamat Datang,\nBu Sari Indah, S.Pd', // Data dummy
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text('SI', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// ===================================================================
// KONTEN TAB DASHBOARD (KARTU KELAS)
// Kita pisah agar rapi dan bisa dimasukkan ke IndexedStack
// ===================================================================

class _DashboardTabContent extends StatelessWidget {
  const _DashboardTabContent();

  @override
  Widget build(BuildContext context) {
    // Ini adalah halaman yang berisi kartu-kartu kelas
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // 1. Pengumuman
        _buildAnnouncementBanner(),
        const SizedBox(height: 20),
        
        // 2. Daftar Kartu Kelas (Responsif)
        LayoutBuilder(
          builder: (context, constraints) {
            // Tentukan lebar minimal untuk mode desktop/tablet
            const double desktopBreakpoint = 700;

            if (constraints.maxWidth < desktopBreakpoint) {
              // --- TAMPILAN HP (Column) ---
              // Tampilkan kartu-kartu secara vertikal ke bawah
              return Column(
                children: [
                  _buildClassCard(
                    'Bahasa Inggris', 'Kelas 7-A', 3, 10, 32, Colors.blue,
                  ),
                  const SizedBox(height: 16), // Beri jarak antar kartu
                  _buildClassCard(
                    'Bahasa Inggris', 'Kelas 7-B', 5, 8, 32, Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildClassCard(
                    'Bahasa Inggris', 'Kelas 7-C', 1, 12, 32, Colors.green,
                  ),
                ],
              );
            } else {
              // --- TAMPILAN DESKTOP/TABLET (Row) ---
              // Tampilkan seperti desain asli (menyamping)
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildClassCard(
                      'Bahasa Inggris', 'Kelas 7-A', 3, 10, 32, Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16), // Jarak antar kartu
                  Expanded(
                    child: _buildClassCard(
                      'Bahasa Inggris', 'Kelas 7-B', 5, 8, 32, Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildClassCard(
                      'Bahasa Inggris', 'Kelas 7-C', 1, 12, 32, Colors.green,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // --- Widget untuk Banner Pengumuman ---
  Widget _buildAnnouncementBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.campaign_outlined, color: Colors.teal.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '5 Tugas baru telah dikumpulkan oleh siswa dan menunggu penilaian Anda!',
              style: TextStyle(color: Colors.teal.shade900),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget untuk Kartu Kelas ---
  Widget _buildClassCard(String mapel, String kelas, int tugasPerluDinilai,
      int pengumpulan, int totalSiswa, Color color) {
    double progress = pengumpulan / totalSiswa;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.book_rounded, color: Colors.white),
            ),
            title: Text(mapel, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(kelas, style: const TextStyle(color: Colors.grey)),
          ),
          const Divider(),
          const SizedBox(height: 10),
          
          // Info Tugas
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                '$tugasPerluDinilai Tugas Perlu Dinilai',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            color: color,
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Text(
            'Progress Pengumpulan (Tugas 7): $pengumpulan/$totalSiswa Siswa',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}