import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/guru_controller.dart';
import '../services/guru_service.dart';
import '../models/guru_models.dart';

class MonitorSiswaScreen extends StatefulWidget {
  const MonitorSiswaScreen({super.key});

  @override
  State<MonitorSiswaScreen> createState() => _MonitorSiswaScreenState();
}

class _MonitorSiswaScreenState extends State<MonitorSiswaScreen> {
  String _selectedKelas = 'Kelas 7B';
  final List<SiswaMonitor> daftarSiswaDummy = GuruService.getDaftarSiswa();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GuruController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => controller.setSelectedIndex(0), // Kembali ke Dashboard
        ),
        title: const Text(
          'Monitor Aktivitas Siswa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildStatistikSection(),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar siswa $_selectedKelas',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 20, color: Colors.teal),
                label: const Text('Refresh', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 14)),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.teal, width: 1.5)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildSiswaList(),
        ],
      ),
    );
  }

  Widget _buildStatistikSection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.3,
      children: [
        _buildStatCard('Siswa Online', '12', Icons.sensors, Colors.green.shade900),
        _buildStatCard('Total Siswa', '28', Icons.people_alt, Colors.blue.shade900),
        _buildStatCard('Tugas Aktif', '5', Icons.assignment, Colors.orange.shade900),
        _buildStatCard('Perlu Review', '8', Icons.rate_review, Colors.purple.shade900),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
          Text(title, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSiswaList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: daftarSiswaDummy.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final siswa = daftarSiswaDummy[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26), 
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.teal.shade100,
                          child: Text(siswa.avatar, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 18)),
                        ),
                        if (siswa.isOnline)
                          const Positioned(bottom: 2, right: 2, child: GreenDotIndicator()),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(siswa.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black)),
                          Text('NIS: ${siswa.nis}', style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)), 
                        ],
                      ),
                    ),
                    _buildStatusChip(siswa.isOnline),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: Colors.black38)),
                _buildInfoRow('Terakhir Aktif', siswa.terakhirOnline, Icons.access_time),
                const SizedBox(height: 10),
                _buildInfoRow('Progress Tugas', siswa.tugasSelesai, Icons.task_alt),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: siswa.progresMateri,
                    backgroundColor: Colors.grey.shade300, 
                    color: Colors.teal.shade800, 
                    minHeight: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(bool online) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: online ? Colors.green.shade800 : Colors.black, 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        online ? 'ONLINE' : 'OFFLINE',
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)), 
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }
}

// WIDGET INDIKATOR HIJAU (Penting agar tidak error)
class GreenDotIndicator extends StatelessWidget {
  const GreenDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
      ),
    );
  }
}