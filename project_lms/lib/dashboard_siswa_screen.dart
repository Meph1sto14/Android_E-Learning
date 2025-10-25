import 'package:flutter/material.dart';
import 'package:project_lms/materi_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Data dummy untuk Mata Pelajaran
  final List<MateriItem> mataPelajaran = const [
    MateriItem(
      title: 'Matematika Kelas VII',
      progress: '75%',
      icon: Icons.calculate_outlined,
      color: Colors.blueAccent,
    ),
    MateriItem(
      title: 'Bahasa Indonesia',
      progress: '40%',
      icon: Icons.book_outlined,
      color: Colors.green,
    ),
    MateriItem(
      title: 'Ilmu Pengetahuan Alam',
      progress: '90%',
      icon: Icons.science_outlined,
      color: Colors.deepOrange,
    ),
    MateriItem(
      title: 'Pendidikan Pancasila',
      progress: '20%',
      icon: Icons.gavel_outlined,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: const Text(
          'Dashboard Siswa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // TODO: Implementasi Logout
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false); // Kembali ke Home Screen
            },
          ),
        ],
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          // Header Selamat Datang
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30)), // Sudut melengkung
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halo, Budi Santoso!', // Ganti dengan nama pengguna
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Selamat datang kembali di LMS SMPN 3 Purwokerto.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Ringkasan Tugas
                  _buildSummaryCard(
                    icon: Icons.pending_actions,
                    title: 'Tugas Menunggu',
                    value: '3 Tugas',
                    color: Colors.white,
                    backgroundColor: Colors.teal.shade500,
                  ),
                ],
              ),
            ),
          ),

          // Judul Bagian Materi
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                'Mata Pelajaran Anda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
            ),
          ),

          // Grid Mata Pelajaran (Menggunakan SliverGrid)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.95, // Rasio agar kartu lebih tinggi
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return MateriCard(item: mataPelajaran[index]);
                },
                childCount: mataPelajaran.length,
              ),
            ),
          ),

          // Spacer di bagian bawah
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }

  // Widget untuk Kartu Ringkasan
  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
