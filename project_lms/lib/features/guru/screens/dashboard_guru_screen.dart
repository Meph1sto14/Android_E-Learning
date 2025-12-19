import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/guru_controller.dart';
import 'monitor_siswa_screen.dart';
import 'penilaian_tugas_screen.dart';
import 'upload_tugas_screen.dart';
import 'upload_materi_screen.dart';

class DashboardGuruScreen extends StatelessWidget {
  const DashboardGuruScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GuruController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        // JUDUL: Sekarang aman karena profil ada di actions
        title: const Text(
          'E-Learning SMPN 3',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // ACTIONS: Profil ditaruh di sini agar otomatis rata kanan
        actions: [
          _buildProfileMenu(context),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFDDDDDD))),
            ),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildMenuButton(context, 'Dashboard', 0, controller),
                _buildMenuButton(context, 'Upload Tugas', 1, controller),
                _buildMenuButton(context, 'Upload Materi', 2, controller),
                _buildMenuButton(context, 'Monitor Siswa', 3, controller),
                _buildMenuButton(context, 'Penilaian', 4, controller),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: controller.selectedIndex,
        children: const [
          _DashboardTabContent(),
          UploadTugasScreen(),
          UploadMateriScreen(),
          MonitorSiswaScreen(),
          PenilaianTugasScreen(),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, int index, GuruController controller) {
    final bool isSelected = controller.selectedIndex == index;
    return FilterChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (_) => controller.setSelectedIndex(index),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      selectedColor: Colors.teal.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: isSelected ? Colors.teal : Colors.black),
      ),
      showCheckmark: false,
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      onSelected: (value) {
        if (value == 'logout') {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Selamat Datang,', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
              Text('Bu Sari Indah', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.teal,
            child: Text('SI', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    );
  }
}

class _DashboardTabContent extends StatelessWidget {
  const _DashboardTabContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildAnnouncementBanner(),
        const SizedBox(height: 20),
        _buildClassCard('Bahasa Inggris', 'Kelas 7-A', 3, 10, 32, Colors.blue.shade900),
        const SizedBox(height: 16),
        _buildClassCard('Bahasa Inggris', 'Kelas 7-B', 5, 8, 32, Colors.orange.shade900),
        const SizedBox(height: 16),
        _buildClassCard('Bahasa Inggris', 'Kelas 7-C', 1, 12, 32, Colors.green.shade900),
      ],
    );
  }

  Widget _buildAnnouncementBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.campaign, color: Colors.teal.shade900, size: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Ada 5 tugas baru yang perlu dinilai hari ini.',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(String mapel, String kelas, int tugasDinilai, int pengumpulan, int total, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mapel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black)),
          Text(kelas, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          const Divider(height: 24, color: Colors.black26),
          Text('$tugasDinilai Tugas Perlu Dinilai', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: (pengumpulan / total).clamp(0.0, 1.0), 
            color: color, 
            backgroundColor: Colors.grey.shade300,
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text('Progres: $pengumpulan/$total Siswa', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}