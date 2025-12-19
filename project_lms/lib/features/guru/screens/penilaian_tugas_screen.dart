import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import project internal
import '../controllers/guru_controller.dart';
import '../models/guru_models.dart';
import '../services/guru_service.dart';

class PenilaianTugasScreen extends StatefulWidget {
  const PenilaianTugasScreen({super.key});

  @override
  State<PenilaianTugasScreen> createState() => _PenilaianTugasScreenState();
}

class _PenilaianTugasScreenState extends State<PenilaianTugasScreen> {
  // State untuk filter tab
  String _selectedFilter = 'Semua';
  
  // Mengambil data dummy dari Service
  final List<TugasUntukDinilai> daftarTugasDummy = GuruService.getDaftarTugas();

  @override
  Widget build(BuildContext context) {
    // Listen: false karena kita hanya butuh memanggil fungsi navigasi
    final controller = Provider.of<GuruController>(context, listen: false);

    // Logika Filtering data
    final filteredList = daftarTugasDummy
        .where((t) => _selectedFilter == 'Semua' || t.status == _selectedFilter)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol Back mengarah ke Dashboard (Index 0)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => controller.setSelectedIndex(0),
        ),
        title: const Text(
          'Penilaian Tugas Siswa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Center(
        child: Container(
          // FOKUS MATA: Membatasi lebar agar guru tidak lelah membaca melebar ke samping
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            children: [
              // 1. Tab Filter
              _buildFilterTabs(),
              const SizedBox(height: 25),
              
              // 2. Ringkasan Statistik Kerja
              _buildStatistikOverview(),
              const SizedBox(height: 25),
              
              // 3. Judul Daftar
              const Text(
                'Daftar Tugas Kelas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 15),

              // 4. List Kartu Tugas
              ListView.builder(
                itemCount: filteredList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _buildTugasCard(filteredList[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Filter Tab (Semua, Belum Dinilai, Sudah Dinilai) ---
  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        children: [
          _buildTabItem('Semua', 0),
          _buildTabItem('Belum Dinilai', 1),
          _buildTabItem('Sudah Dinilai', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isSelected = (_selectedFilter == 'Semua' && index == 0) ||
                      (_selectedFilter == 'Belum Dinilai' && index == 1) ||
                      (_selectedFilter == 'Sudah Dinilai' && index == 2);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (index == 0) _selectedFilter = 'Semua';
            if (index == 1) _selectedFilter = 'Belum Dinilai';
            if (index == 2) _selectedFilter = 'Sudah Dinilai';
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal.shade800 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Kartu Tugas (Item List) ---
  Widget _buildTugasCard(TugasUntukDinilai tugas) {
    bool isPending = tugas.status == 'Belum Dinilai';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // Border Orange Tebal jika Belum Dinilai agar guru teliti
        border: Border.all(
          color: isPending ? Colors.orange.shade800 : Colors.black26, 
          width: isPending ? 2.0 : 1.0,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tugas.judul,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                  ),
                ),
                _buildStatusChip(tugas.status),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Kelas: ${tugas.kelas} | ${tugas.mataPelajaran}',
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Divider(height: 1, color: Colors.black26)),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatInfo('SUBMIT', '${tugas.sudahSubmit}/${tugas.totalSiswa}'),
                _buildStatInfo('BELUM DINILAI', tugas.belumDinilai.toString(), 
                  color: isPending ? Colors.red.shade900 : Colors.black),
                _buildStatInfo('RATA-RATA', tugas.rataRata.toString()),
              ],
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi navigasi ke detail nilai
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPending ? Colors.teal.shade800 : Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  isPending ? 'MULAI MENILAI SEKARANG' : 'LIHAT HASIL PENILAIAN',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    bool isDone = status == 'Sudah Dinilai';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDone ? Colors.green.shade800 : Colors.orange.shade800,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatInfo(String label, String value, {Color color = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  // --- WIDGET HELPER: Banner Ringkasan Atas ---
  Widget _buildStatistikOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade400, width: 1.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.analytics, color: Colors.teal, size: 35),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Ringkasan Kerja Anda',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                ),
                SizedBox(height: 2),
                Text(
                  'Total 5 Tugas Aktif | 2 Perlu Dinilai Segera',
                  style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}