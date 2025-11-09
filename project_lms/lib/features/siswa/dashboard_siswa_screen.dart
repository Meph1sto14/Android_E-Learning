import 'package:flutter/material.dart';
import 'package:project_lms/features/shared/widgets/materi_card.dart';

class DashboardSiswaScreen extends StatelessWidget {
  const DashboardSiswaScreen({super.key});

  final List<MateriItem> mataPelajaran = const [
    MateriItem(
      title: 'Matematika',
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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          _buildSectionTitle('Mata Pelajaran Anda'),
          _buildMateriGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  /// === App Bar ===
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal.shade700,
      title: const Text(
        'Dashboard Siswa',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ],
      elevation: 0,
    );
  }

  /// === Header Section (Halo + Progress + Tombol) ===
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
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
            'Halo, Siswa dan Siswi!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Selamat datang kembali di LMS SMPN 3 Purwokerto.',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _buildProgressCard(),
          const SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  /// === Progress Card ===
  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.show_chart, color: Colors.teal, size: 30),
              SizedBox(width: 10),
              Text(
                'Progress Pelajaran Anda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.6,
              color: Colors.teal,
              backgroundColor: Colors.tealAccent,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '60% dari pelajaran sudah dipelajari',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// === Tombol Navigasi (Tugas & Nilai) ===
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            label: 'Lihat Daftar Tugas',
            icon: Icons.assignment_outlined,
            color: Colors.teal.shade600,
            onTap: () {
              Navigator.pushNamed(context, '/tugas'); // BARU
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildActionButton(
            label: 'Lihat Hasil Nilai',
            icon: Icons.bar_chart_rounded,
            color: Colors.green.shade600,
            onTap: () {
              Navigator.pushNamed(context, '/nilai'); // BARU
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// === Judul Section ===
  SliverToBoxAdapter _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
      ),
    );
  }

  /// === Grid Mata Pelajaran ===
  SliverPadding _buildMateriGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.95,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => MateriCard(item: mataPelajaran[index]),
          childCount: mataPelajaran.length,
        ),
      ),
    );
  }
}
