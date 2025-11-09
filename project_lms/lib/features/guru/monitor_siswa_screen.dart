import 'package:flutter/material.dart';

// 1. Model Data (Sama seperti sebelumnya)
class SiswaMonitor {
  final String nama;
  final String nis;
  final String avatar; // Inisial (LM, RA, KP)
  final bool isOnline;
  final String terakhirOnline;
  final double progresMateri; // 0.0 sampai 1.0
  final String tugasSelesai; // "4/5"

  SiswaMonitor({
    required this.nama,
    required this.nis,
    required this.avatar,
    required this.isOnline,
    required this.terakhirOnline,
    required this.progresMateri,
    required this.tugasSelesai,
  });
}

// 2. Data Dummy (Sama seperti sebelumnya)
final List<SiswaMonitor> daftarSiswaDummy = [
  SiswaMonitor(
    nama: 'Agus Wibowo', nis: '232251', avatar: 'AW', isOnline: true,
    terakhirOnline: 'Sekarang', progresMateri: 0.8, tugasSelesai: '4/5',
  ),
  SiswaMonitor(
    nama: 'Rizaldy Aulia', nis: '232251', avatar: 'RA', isOnline: false,
    terakhirOnline: '3 jam yang lalu', progresMateri: 0.5, tugasSelesai: '3/5',
  ),
  SiswaMonitor(
    nama: 'Kafka Putra', nis: '232251', avatar: 'KP', isOnline: true,
    terakhirOnline: 'Sekarang', progresMateri: 0.2, tugasSelesai: '2/5',
  ),
];

class MonitorSiswaScreen extends StatefulWidget {
  const MonitorSiswaScreen({super.key});

  @override
  State<MonitorSiswaScreen> createState() => _MonitorSiswaScreenState();
}

class _MonitorSiswaScreenState extends State<MonitorSiswaScreen> {
  String _selectedKelas = 'Kelas 7B'; // Untuk dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Aktivitas Siswa'),
        // --- Bagian Filter ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: _buildFilterSection(),
        ),
      ),
      body: ListView( // Ganti ke ListView agar bisa di-scroll
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Bagian Statistik (Siswa Online, Total, dll) ---
          _buildStatistikCards(),
          const SizedBox(height: 24),

          // --- Bagian Daftar Siswa ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar siswa $_selectedKelas',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              OutlinedButton.icon(
                onPressed: () { /* TODO: Logika refresh data */ },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
              )
            ],
          ),
          const SizedBox(height: 12),
          
          // --- PERBAIKAN 2: Ganti DataTable dengan ListView ---
          _buildSiswaList(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    // TODO: Implementasikan Dropdown dan Search Bar yang fungsional
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Ganti Text ini dengan DropdownButton
          Expanded(
            child: Text('Kelas: $_selectedKelas', style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          // Ganti Text ini dengan DropdownButton
          const Expanded(
            child: Text('Status: Semua', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          // Ganti Text ini dengan TextField
          const Expanded(
            child: Text('Cari Nama...', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistikCards() {
    // --- PERBAIKAN 1: Ubah crossAxisCount dari 4 menjadi 2 ---
    return GridView.count(
      crossAxisCount: 2, // 2 kolom agar muat di HP
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.8, // Buat kartu sedikit lebih lebar
      children: [
        _buildStatCard('Siswa Online', '12', Icons.wifi, Colors.green),
        _buildStatCard('Total Siswa', '28', Icons.group_outlined, Colors.blue),
        _buildStatCard('Tugas Aktif', '5', Icons.assignment_outlined, Colors.orange),
        _buildStatCard('Menunggu Review', '8', Icons.rate_review_outlined, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      color: color.withAlpha(25), // Alternatif solid color: color.shade50
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BARU: Menggantikan _buildSiswaDataTable ---
  Widget _buildSiswaList() {
    // Gunakan ListView.builder, bukan DataTable
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: daftarSiswaDummy.length,
      itemBuilder: (context, index) {
        final siswa = daftarSiswaDummy[index];
        return _buildSiswaCard(siswa); // Buat widget Card kustom
      },
    );
  }

  // --- WIDGET BARU: Kartu Siswa yang Mobile-Friendly ---
  Widget _buildSiswaCard(SiswaMonitor s) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian 1: Info Utama (Avatar, Nama, Status)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 20,
                child: Text(s.avatar),
              ),
              title: Text(s.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('NIS: ${s.nis}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: s.isOnline ? Colors.green.shade50 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  s.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: s.isOnline ? Colors.green.shade700 : Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Divider(),
            
            // Bagian 2: Info Detail (Stack vertikal)
            _buildInfoRow('Terakhir Online:', s.terakhirOnline),
            const SizedBox(height: 8),
            _buildInfoRow('Tugas Selesai:', s.tugasSelesai),
            const SizedBox(height: 8),
            
            // Progres Bar
            Text(
              'Progres Materi: ${(s.progresMateri * 100).toInt()}%',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: s.progresMateri,
              backgroundColor: Colors.grey.shade200,
              color: Colors.blue,
            ),
            
            // Bagian 3: Tombol Aksi
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.visibility_outlined, size: 18, color: Colors.blue),
                  label: const Text('Lihat', style: TextStyle(color: Colors.blue)),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.green),
                  label: const Text('Pesan', style: TextStyle(color: Colors.green)),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget helper untuk baris info di dalam kartu
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}