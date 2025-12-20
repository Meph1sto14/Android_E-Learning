import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/guru_controller.dart';
import '../models/guru_models.dart';

class PenilaianTugasScreen extends StatelessWidget {
  const PenilaianTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GuruController>(
      builder: (context, controller, child) {
        final filteredList = controller.filteredTugas;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
              onPressed: () => controller.setSelectedIndex(0),
            ),
            title: const Text('Penilaian Tugas Siswa', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  children: [
                    _buildFilterTabs(controller),
                    const SizedBox(height: 25),
                    const Text('Daftar Tugas Kelas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    if (filteredList.isEmpty) const Center(child: Text('Tidak ada tugas.'))
                    else ListView.builder(
                      itemCount: filteredList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _buildTugasCard(filteredList[index]),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildFilterTabs(GuruController controller) {
    return Row(
      children: ['Semua', 'Belum Dinilai', 'Sudah Dinilai'].map((label) {
        bool isSelected = controller.selectedFilter == label;
        return Expanded(
          child: GestureDetector(
            onTap: () => controller.updateFilter(label),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: isSelected ? Colors.teal.shade800 : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black12)),
              child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTugasCard(TugasUntukDinilai tugas) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tugas.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('${tugas.kelas} | ${tugas.mataPelajaran}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCol('SUBMIT', '${tugas.sudahSubmit}/${tugas.totalSiswa}'),
                _buildInfoCol('BELUM DINILAI', tugas.belumDinilai.toString()),
                _buildInfoCol('RATA-RATA', tugas.rataRata.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCol(String label, String value) {
    return Column(children: [
      Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    ]);
  }
}