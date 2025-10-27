import 'package:flutter/material.dart';
import 'package:project_lms/kirim_tugas_screen.dart';

class TugasScreen extends StatelessWidget {
  const TugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tugasPerTanggal = {
      "Senin, 14 Mei 2025": [
        {"mapel": "Matematika", "judul": "Pengumpulan Tugas Minggu ke-2"},
        {"mapel": "Seni Budaya", "judul": "Pengumpulan Tugas Minggu ke-2"},
        {"mapel": "Bahasa Jawa", "judul": "Pengumpulan Tugas Minggu ke-2"},
      ],
      "Senin, 21 Mei 2025": [
        {"mapel": "Bahasa Inggris", "judul": "Pengumpulan Tugas Minggu ke-3"},
        {
          "mapel": "Ilmu Pengetahuan Sosial",
          "judul": "Pengumpulan Tugas Minggu ke-3"
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: const Text(
          'Daftar Tugas Anda',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tugasPerTanggal.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                ...entry.value.map((tugas) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file_outlined,
                            color: Colors.teal, size: 30),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tugas["judul"]!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${tugas["mapel"]} - Pengumpulan Jatuh Tempo',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KirimTugasScreen(
                                  mapel: tugas["mapel"]!,
                                  judul: tugas["judul"]!,
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.teal.shade700),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Kirimkan Tugas',
                            style: TextStyle(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
