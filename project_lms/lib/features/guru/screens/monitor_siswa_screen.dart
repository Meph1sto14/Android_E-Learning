import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/guru_controller.dart';
import '../models/guru_models.dart';

class MonitorSiswaScreen extends StatelessWidget {
  const MonitorSiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
              onPressed: () => controller.setSelectedIndex(0),
            ),
            title: const Text(
              'Monitor Aktivitas Siswa',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    _buildStatistikSection(),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar siswa ${controller.selectedKelas}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => controller.fetchSiswa(), // SEKARANG SUDAH ADA
                          icon: const Icon(Icons.refresh, size: 20, color: Colors.teal),
                          label: const Text('Refresh', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.teal, width: 1.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildSiswaList(controller),
                  ],
                ),
        );
      },
    );
  }

  // --- Widget Helper: List Siswa ---
  Widget _buildSiswaList(GuruController controller) {
    if (controller.daftarSiswa.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(20.0), child: Text('Tidak ada data siswa.')));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.daftarSiswa.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final siswa = controller.daftarSiswa[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: CircleAvatar(child: Text(siswa.avatar)),
            title: Text(siswa.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('NIS: ${siswa.nis} | Progress: ${(siswa.progresMateri * 100).toInt()}%'),
            trailing: Icon(Icons.circle, color: siswa.isOnline ? Colors.green : Colors.grey, size: 12),
          ),
        );
      },
    );
  }

  // --- Widget Helper: Statistik ---
  Widget _buildStatistikSection() {
    return GridView.count(
      crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.3,
      children: [
        _buildStatCard('Siswa Online', '3', Icons.sensors, Colors.green),
        _buildStatCard('Total Siswa', '1', Icons.people_alt, Colors.blue),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: color, size: 28),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}