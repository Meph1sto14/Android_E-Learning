import 'package:flutter/material.dart';

// 1. Model Data (Sama seperti sebelumnya)
class TugasUntukDinilai {
  final String judul;
  final String kelas;
  final String mataPelajaran;
  final int totalSiswa;
  final int sudahSubmit;
  final int belumDinilai;
  final double rataRata;
  final String status; // 'Belum Dinilai' atau 'Sudah Dinilai'

  TugasUntukDinilai({
    required this.judul,
    required this.kelas,
    required this.mataPelajaran,
    required this.totalSiswa,
    required this.sudahSubmit,
    required this.belumDinilai,
    required this.rataRata,
    required this.status,
  });
}

// 2. Data Dummy (Sama seperti sebelumnya)
final List<TugasUntukDinilai> daftarTugasDummy = [
  TugasUntukDinilai(
    judul: 'Pr Daily Activity', kelas: '7A', mataPelajaran: 'Bahasa Inggris',
    totalSiswa: 28, sudahSubmit: 28, belumDinilai: 6, rataRata: 8.5, status: 'Belum Dinilai',
  ),
  TugasUntukDinilai(
    judul: 'Pr Daily Activity', kelas: '7B', mataPelajaran: 'Bahasa Inggris',
    totalSiswa: 30, sudahSubmit: 30, belumDinilai: 0, rataRata: 9.2, status: 'Sudah Dinilai',
  ),
  TugasUntukDinilai(
    judul: 'Pr Daily Activity', kelas: '7C', mataPelajaran: 'Bahasa Inggris',
    totalSiswa: 31, sudahSubmit: 31, belumDinilai: 0, rataRata: 9.0, status: 'Sudah Dinilai',
  ),
];

class PenilaianTugasScreen extends StatefulWidget {
  const PenilaianTugasScreen({super.key});

  @override
  State<PenilaianTugasScreen> createState() => _PenilaianTugasScreenState();
}

class _PenilaianTugasScreenState extends State<PenilaianTugasScreen> {
  String _selectedFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan tab yang dipilih
    final filteredList = daftarTugasDummy.where((tugas) {
      if (_selectedFilter == 'Semua') return true;
      return tugas.status == _selectedFilter;
    }).toList();

    // Hapus 'Scaffold' dan 'AppBar'. 
    // Ganti 'Row' dengan 'ListView' untuk tata letak mobile.
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Filter Tabs (pindahkan dari AppBar ke body)
        _buildFilterTabs(),
        const SizedBox(height: 24),

        // 2. Konten Sidebar (sekarang jadi kartu di atas)
        _buildSidebarStatistik(),
        const SizedBox(height: 16),
        _buildSidebarPengingat(),
        const SizedBox(height: 24),

        // 3. Judul "Penilaian Tugas"
        const Text(
          'Penilaian Tugas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text('Kelola dan berikan penilaian untuk tugas siswa'),
        const SizedBox(height: 16),
        
        // 4. Daftar Kartu Tugas (ListView di dalam ListView)
        ListView.builder(
          itemCount: filteredList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final tugas = filteredList[index];
            return _buildTugasCard(tugas);
          },
        ),
      ],
    );
  }

  // --- WIDGET BARU UNTUK FILTER TABS ---
  Widget _buildFilterTabs() {
    return Center(
      child: ToggleButtons(
        isSelected: [
          _selectedFilter == 'Semua',
          _selectedFilter == 'Belum Dinilai',
          _selectedFilter == 'Sudah Dinilai',
        ],
        onPressed: (index) {
          setState(() {
            if (index == 0) _selectedFilter = 'Semua';
            if (index == 1) _selectedFilter = 'Belum Dinilai';
            if (index == 2) _selectedFilter = 'Sudah Dinilai';
          });
        },
        borderRadius: BorderRadius.circular(8.0),
        constraints: const BoxConstraints(minHeight: 40.0),
        selectedColor: Colors.teal,
        fillColor: Colors.teal.withOpacity(0.1),
        children: const [
          Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Semua')),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Belum Dinilai')),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Sudah Dinilai')),
        ],
      ),
    );
  }

  // --- PERBAIKAN PADA KARTU TUGAS ---
  Widget _buildTugasCard(TugasUntukDinilai tugas) {
    final bool sudahDinilai = tugas.status == 'Sudah Dinilai';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Kartu (Judul & Status) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tugas.judul} - Kelas ${tugas.kelas}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(tugas.mataPelajaran, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (sudahDinilai ? Colors.green : Colors.orange).shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tugas.status,
                    style: TextStyle(
                      color: (sudahDinilai ? Colors.green : Colors.orange).shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // --- PERBAIKAN: Statistik Angka (GridView 2x2) ---
            GridView.count(
              crossAxisCount: 2, // 2 kolom
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 3.5, // Atur rasio agar tidak terlalu tinggi
              children: [
                _buildStatColumn('Total Siswa', tugas.totalSiswa.toString()),
                _buildStatColumn('Sudah Submit', tugas.sudahSubmit.toString()),
                _buildStatColumn('Belum Dinilai', tugas.belumDinilai.toString()),
                _buildStatColumn('Rata-rata', tugas.rataRata.toString()),
              ],
            ),
            const SizedBox(height: 20),

            // --- Tombol Aksi ---
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigasi ke halaman detail penilaian untuk kelas ini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: sudahDinilai ? Colors.grey.shade300 : Theme.of(context).primaryColor,
                  foregroundColor: sudahDinilai ? Colors.black : Colors.white
                ),
                child: Text(sudahDinilai ? 'Lihat Hasil' : 'Mulai Menilai'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper untuk Statistik di dalam Kartu ---
  Widget _buildStatColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // --- Helper untuk Konten Sidebar 1 ---
  Widget _buildSidebarStatistik() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik Penilaian',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildStatSidebarRow('Total Tugas Aktif', '5'),
            _buildStatSidebarRow('Belum Dinilai', '6'),
            _buildStatSidebarRow('Selesai Dinilai', '83'),
            _buildStatSidebarRow('Rata-rata Kelas', '8.9'),
          ],
        ),
      ),
    );
  }
  
  // --- Helper untuk Konten Sidebar 2 ---
  Widget _buildSidebarPengingat() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengingat Deadline',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDeadlineRow('Pr Kelas 7B berakhir dalam 2 hari', Colors.red),
            _buildDeadlineRow('Pr Kelas 7A berakhir dalam 4 hari', Colors.orange),
          ],
        ),
      ),
    );
  }

  // --- Helper untuk baris di Sidebar Statistik ---
  Widget _buildStatSidebarRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- Helper untuk baris di Sidebar Pengingat ---
  Widget _buildDeadlineRow(String text, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.circle, color: color, size: 10),
      title: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}